#!/bin/sh

echo "Accessing concentrator reset pin through GPIO$RESET_PIN..."

WAIT_GPIO() {
    sleep 0.1
}

iot_sk_init() {
    # setup GPIO 7
    echo "$RESET_PIN" > /sys/class/gpio/export; WAIT_GPIO

    # set GPIO 7 as output
    echo "out" > /sys/class/gpio/gpio$RESET_PIN/direction; WAIT_GPIO

    # write output for SX1301 reset
    echo "1" > /sys/class/gpio/gpio$RESET_PIN/value; WAIT_GPIO
    echo "0" > /sys/class/gpio/gpio$RESET_PIN/value; WAIT_GPIO

    # set GPIO 7 as input
    echo "in" > /sys/class/gpio/gpio$RESET_PIN/direction; WAIT_GPIO
}

iot_sk_term() {
    if [ -d /sys/class/gpio/gpio$RESET_PIN ]
    then
        echo "$RESET_PIN" > /sys/class/gpio/unexport; WAIT_GPIO
    fi
}


iot_sk_term
iot_sk_init
./forwarder
