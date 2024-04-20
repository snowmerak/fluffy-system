FROM golang:1.22.2-bookworm

RUN go install github.com/bufbuild/buf/cmd/buf@v1.30.1
RUN go install github.com/sqlc-dev/sqlc/cmd/sqlc@latest

CMD ["/bin/sh", "-c", "while true; do sleep 30; done;"]
