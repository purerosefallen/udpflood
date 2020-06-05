FROM debian:buster-slim as builder
RUN apt update && \
	apt -y install build-essential libssl-dev && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /usr/src/app
WORKDIR /usr/src/app
RUN make -j$(nproc)

FROM debian:buster-slim
RUN apt update && \
	apt -y install build-essential libssl-dev && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
COPY --from=builder /usr/src/app/bin/Release/udpflood /usr/local/bin/udpflood

ENTRYPOINT [ "/usr/local/bin/udpflood" ]
