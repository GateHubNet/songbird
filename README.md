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

Built on latest Alpine or Ubuntu base. 

### **Ports exposed:**
- `9650/tcp - http port`
- `9651/tcp - staking port`
---
### **Run with docker**
```
docker run -d -p 9650:9650 -p 9651:9651 --name=songbird ghcr.io/gatehubnet/songbird:alpine|ubuntu
```
If you need persistent storage for database mount directory into `/flare/.flare/db`

```
docker run -d -p 9650:9650 -p 9651:9651 -v /some/directory:/flare/.flare/db --name=songbird ghcr.io/gatehubnet/songbird:alpine|ubuntu
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
        image: ghcr.io/gatehubnet/songbird:alpine|ubuntu
        restart: unless-stopped
```
