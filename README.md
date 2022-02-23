<p align="center">
    <a href="https://gatehub.net">
      <img src="https://cdn.gatehub.net/img/gatehub_logo_blue.svg" alt="GateHub"/ width="500px">
    </a>
</p>

# 🕊️ **GateHub containerized SGB node** 🕊️
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/gatehubnet/songbird/Docker%20Test?color=blue&label=test&style=plastic)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/gatehubnet/songbird/Docker%20Image?style=plastic&logo=docker&color=blue)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/gatehubnet/songbird?label=latest&style=plastic)
![GitHub top language](https://img.shields.io/github/languages/top/gatehubnet/songbird?color=blue&style=plastic)
![GitHub](https://img.shields.io/github/license/gatehubnet/songbird?color=blue&style=plastic)

Containerized image for songbird node with canary network

## **Description**

Custom built songbird container image from [Flare Foundation Repo](https://github.com/flare-foundation/flare).

Information about how Flare works at the network-level is available at [Flare Docs](https://docs.flare.network/en/).

Built on latest Alpine or Ubuntu base. Latest tag always refers to latest Alpine build. ([see docker section](#docker-image-tags))

## **The minimum recommended hardware specification for nodes connected to Mainnet is:**

- CPU: Equivalent of 8 AWS vCPU
- RAM: 16 GiB
- Storage: 512 GiB
- OS: Ubuntu 18.04/20.04 or macOS >= 10.15 (Catalina)
- Network: Reliable IPv4 or IPv6 network connection, with an open public port.

### **Ports exposed:**
- `9650/tcp - http port`
- `9651/tcp - staking port`
---
## **Run with docker**
```
docker run -d -p 9650:9650 -p 9651:9651 --name=songbird ghcr.io/gatehubnet/songbird
```
If you need persistent storage for database mount directory into `/flare/.flare/db`

```
docker run -d -p 9650:9650 -p 9651:9651 -v /some/directory:/flare/.flare/db --name=songbird ghcr.io/gatehubnet/songbird
```
Using docker-compose
```
version: '3.3'
services:
    songbird:
        ports:
            - '9650:9650'
            - '9651:9651'
        volumes:
            - '/some/directory:/flare/.flare/db'
        container_name: songbird
        image: ghcr.io/gatehubnet/songbird
        restart: unless-stopped
```
#### **Docker image tags**
Possible tags for running prefered base flavor or specific version:
```
ghcr.io/gatehubnet/songbird (latest)
ghcr.io/gatehubnet/songbird:latest (latest same as above)
-
ghcr.io/gatehubnet/songbird:alpine (latest alpine same as :latest tag)
ghcr.io/gatehubnet/songbird:v0.5.2-alpine (specific version of alpine flavor)
-
ghcr.io/gatehubnet/songbird:ubuntu (latest ubuntu flavor)
ghcr.io/gatehubnet/songbird:v0.5.2-ubuntu (specific version of ubuntu flavor)
```

## **Pruning & APIs**
The configuration for the chain is loaded from a configuration file, located at `{chain-config-dir}/C/config.json` (`/flare/.flare/configs/chain`).

Here are the most relevant default settings:

```{
  "snowman-api-enabled": false,
  "coreth-admin-api-enabled": false,
  "eth-apis": [
    "public-eth",
    "public-eth-filter",
    "net",
    "web3",
    "internal-public-eth",
    "internal-public-blockchain",
    "internal-public-transaction-pool"
  ],
  "rpc-gas-cap": 50000000,
  "rpc-tx-fee-cap": 100,
  "pruning-enabled": true,
  "local-txs-enabled": false,
  "api-max-duration": 0,
  "api-max-blocks-per-request": 0,
  "allow-unfinalized-queries": false,
  "allow-unprotected-txs": false,
  "remote-tx-gossip-only-enabled": false,
  "log-level": "info"
}
```
You can refer to the original [Avalanche documentation](https://docs.avax.network/build/references/avalanchego-config-flags/#c-chain-configs) for a full list of all settings and a detailed description.

The directory for configuration files defaults to `/flare/.flare/configs/chains` and can be changed using the `--chain-config-dir` flag.

In order to disable pruning and run a full archival node, pruning-enabled should be set to false.

The various node APIs can also be enabled and disabled by setting the respective parameters.

## **FAQ**
- Version numbering:
  - Version changed from `v1.5.2` to `v0.5.x` since Flare dropped avalanche go version for versioning and used their own starting from `v1.6.5` to `v0.0.1`
