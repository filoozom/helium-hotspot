FROM alpine as builder

ARG SPI_SPEED=2000000

RUN apk add --no-cache git gcc make musl-dev linux-headers \
	&& git clone --single-branch --branch env https://github.com/filoozom/packet_forwarder.git \
	&& git clone --single-branch https://github.com/Lora-net/lora_gateway \
	&& cd lora_gateway \
	&& sed -i 's/^#define SPI_SPEED\( *\)[^ ]*$/#define SPI_SPEED\1'"$SPI_SPEED"'/g' libloragw/src/loragw_spi.native.c \
	&& make \
	&& cd ../packet_forwarder/lora_pkt_fwd \
	&& make \
	&& chmod +x lora_pkt_fwd

FROM busybox
WORKDIR /app

COPY --from=builder /packet_forwarder/lora_pkt_fwd/lora_pkt_fwd ./forwarder
COPY entrypoint.sh config/global_conf.json ./

RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

