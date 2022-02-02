<p align="center">
    <a href="https://gatehub.net">
      <img src="https://cdn.gatehub.net/img/gatehub_logo_blue.svg" alt="GateHub"/ width="500px">
    </a>
</p>

# 🕊️ **GateHub containerized SGB node** 🕊️
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/gatehubnet/songbird/Docker%20Image?style=plastic&logo=docker&color=blue)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/gatehubnet/songbird/Docker%20Test?style=plastic&logo=docker&color=blue)
![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/gatehubnet/songbird?label=latest&style=plastic)
![GitHub top language](https://img.shields.io/github/languages/top/gatehubnet/songbird?color=blue&style=plastic)
![GitHub](https://img.shields.io/github/license/gatehubnet/songbird?color=blue&style=plastic)

Containerized image for songbird node with canary network

## **Description**

Custom built songbird container image from [Flare Network Repo](https://gitlab.com/flarenetwork/flare).

Information about how Flare works at the network-level is available at [Flare Docs](https://docs.flare.network/en/).

Built on latest Ubuntu base. 

### **Ports exposed:**
- 9650/tcp - http port
- 9651/tcp - staking port


### **Custom variables**
Image supports variables for setting SGB node type and log level verbosity. Variables are optional and without them defaults will be used.

🔵 **SGB_NODE_TYPE**
```
- SGB_NODE_TYPE=pruning - pruning node (enabled by default)
- SGB_NODE_TYPE=full - full node
```

🔵 **SGB_LOG_LEVEL**
```
- SGB_LOG_LEVEL=info - informative log output (enabled by default)
- SGB_LOG_LEVEL=debug - detailed log output
```
---
### **Run with docker**
```
docker run -d -p 9650:9650 -p 9651:9651 -e SGB_NODE_TYPE=pruning -e SGB_LOG_LEVEL=info --name=songbird ghcr.io/gatehubnet/songbird
```
If you need persistent storage for database mount directory into `/flare/db`

```
docker run -d -p 9650:9650 -p 9651:9651 -e SGB_NODE_TYPE=pruning -e SGB_LOG_LEVEL=info -v /some/directory:/flare/db --name=songbird ghcr.io/gatehubnet/songbird
```
Using docker-compose
```
version: '3.3'
services:
    songbird:
        ports:
            - '9650:9650'
            - '9651:9651'
        environment:
            - SGB_NODE_TYPE=pruning
            - SGB_LOG_LEVEL=info
        volumes:
            - '/some/directory:/flare/db'
        container_name: songbird
        image: ghcr.io/gatehubnet/songbird
        restart: unless-stopped
```
