FROM ubuntu:24.04
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install build-essential cmake pkgconf python3 libevent-dev libboost-dev libsqlite3-dev libzmq3-dev systemtap-sdt-dev libcapnp-dev capnproto -y
WORKDIR /app
COPY . .
RUN mv /app/bin/bitcoind /app/bitcoind
RUN mv /app/bin/bitcoin-cli /app/bitcoin-cli
CMD /app/bitcoind -printtoconsole
