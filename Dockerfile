FROM golang:1
WORKDIR /go/src/github.com/imagespy/docker_discoverer/
COPY . .
RUN make

FROM gcr.io/distroless/base
COPY --from=0 /go/src/github.com/imagespy/docker_discoverer/docker_discoverer /docker_discoverer
USER nobody
ENTRYPOINT ["/docker_discoverer"]
