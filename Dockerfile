FROM golang:1.17-buster as builder

RUN apt update && apt -y install openssh-server git 
RUN mkdir /app
WORKDIR /app
COPY . .
ENV GOPRIVATE=github.com/neutron-org/neutron
RUN go mod download && \
    go build -a -o /go/bin/neutron_query_relayer ./cmd/neutron_query_relayer

FROM debian:buster
RUN apt update && apt install ca-certificates curl -y && apt-get clean
ADD ["https://github.com/CosmWasm/wasmvm/raw/v1.0.0/api/libwasmvm.x86_64.so", "https://github.com/CosmWasm/wasmvm/raw/v1.0.0/api/libwasmvm.aarch64.so", "/lib/"]
ADD run.sh .
COPY --from=builder /go/bin/neutron_query_relayer /bin/
EXPOSE 9999

ENTRYPOINT ["neutron_query_relayer"]