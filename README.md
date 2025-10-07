# Fractal Bitcoin Overview

**Website:** [Fractal Bitcoin](https://fractalbitcoin.io)

## What is Fractal Bitcoin?

Fractal Bitcoin is the only Bitcoin scaling solution that uses the Bitcoin Core code itself to recursively scale unlimited layers on top of the world’s most-secure and -held blockchain.

It is the first instance of a virtualization methodology applied to Bitcoin in the world. Fractal gradually extends the Bitcoin blockchain into a scalable computing system without breaking consistency with the Bitcoin main chain.

With strong tooling and support, building on Fractal is straightforward.

## Getting Started

### System Requirements

| Node Type   | CPU     | RAM  | Storage (Mainnet)   | Storage (Testnet) |
| ----------- | ------- | ---- | ------------------- | ----------------- |
| Full Node   | 2 cores | 8 GB | 2 TB                | 300 GB            |
| Mining Node | 2 cores | 4 GB | 300 GB (prune mode) | 100 GB            |

- For more details of Prune Mode, please check: [2025.07 Fractal Prune Mode Explained](./2025-07-13-prune-mode.md)


**1. Docker Installation**
```
# Download and extract release
wget https://github.com/fractal-bitcoin/fractald-release/releases/download/v0.2.9rc2/fractald-0.2.9rc2-x86_64-linux-gnu.tar.gz
tar -zxvf fractald-0.2.9rc2-x86_64-linux-gnu.tar.gz
```
```
cd fractald-0.2.9rc2-x86_64-linux-gnu
```

```
sudo nano Dockerfile
```

## Configuration

**Dockerfile**
```
FROM ubuntu:24.04
RUN apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install build-essential cmake pkgconf python3 libevent-dev libboost-dev libsqlite3-dev libzmq3-dev systemtap-sdt-dev libcapnp-dev capnproto -y
WORKDIR /app
COPY . .
RUN mv /app/bin/bitcoind /app/bitcoind
RUN mv /app/bin/bitcoin-cli /app/bitcoin-cli
CMD /app/bitcoind -printtoconsole
```
**Build local docker image**
```
docker build -t fractal .
```

**Mainnet Setup**

Example bitcoin.conf:

```
server=1
port=8332
rpcport=9002
rpcuser=user
rpcpassword=password
prune=10000
wallet=default
zmqpubhashblock=tcp://127.0.0.1:6002
```
```
sudo mkdir -p /data
```
Place your bitcoin.conf into /data folder

**Pruning (Space Saving)**

```
prune=10000  # Keeps ~10GB of blocks
# Pruning activates after block 10,000 since v0.2.3 (was 100,000 before).
```

**Run docker container from local image**
```
sudo docker run -d --network host --name fractal --restart
always --log-opt max-size=10m -v /data:/root/.bitcoin fractal
```
**Create wallet**
```
sudo docker exec fractal /app/bitcoin-cli createwallet default
```
**Create wallet address**
```
sudo docker exec fractal /app/bitcoin-cli getnewaddress "" "legacy"
```
## Build Fractal Bitcoin

The following are developer notes on how to build Bitcoin Core on your native platform. They are not complete guides, but include notes on the necessary libraries, compile flags, etc.

- [Dependencies](https://github.com/fractal-bitcoin/fractal/blob/main/doc/dependencies.md)
- [macOS Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-osx.md)
- [Unix Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-unix.md)
- [Windows Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-windows.md)
- [FreeBSD Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-freebsd.md)
- [OpenBSD Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-openbsd.md)
- [NetBSD Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-netbsd.md)
- [Android Build Notes](https://github.com/fractal-bitcoin/fractal/blob/main/doc/build-android.md)
