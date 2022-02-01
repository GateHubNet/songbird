FROM ubuntu:latest AS builder

SHELL ["/bin/bash", "--login", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV GOPATH=/go
ENV PATH=$PATH:/usr/local/go/bin

RUN apt update && apt upgrade -y
RUN apt install -y git gcc g++ curl jq
RUN curl -L -s -o go1.15.14.linux-amd64.tar.gz https://go.dev/dl/go1.15.14.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xvf go1.15.14.linux-amd64.tar.gz 
RUN rm go1.15.14.linux-amd64.tar.gz
RUN apt install -y nodejs npm
RUN npm install --global yarn@1.22.10

WORKDIR /
RUN mkdir /go
RUN git clone https://gitlab.com/flarenetwork/flare
WORKDIR /flare

RUN ./compile.sh songbird

FROM ubuntu:latest AS execution

SHELL ["/bin/bash", "--login", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV GOPATH=/go
ENV PATH=$PATH:/usr/local/go/bin

RUN apt update -y && apt upgrade -y
RUN apt install -y bash curl jq

RUN curl -L -s -o go1.15.14.linux-amd64.tar.gz https://go.dev/dl/go1.15.14.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xvf go1.15.14.linux-amd64.tar.gz && rm go1.15.14.linux-amd64.tar.gz

COPY --from=builder /go/src/github.com/ava-labs/avalanchego/build/ /go/src/github.com/ava-labs/avalanchego/build
COPY --from=builder /flare /flare

WORKDIR /flare

COPY songbird.sh /flare/cmd/songbird.sh
RUN chmod +x /flare/cmd/songbird.sh

CMD [ "./cmd/songbird.sh" ]
