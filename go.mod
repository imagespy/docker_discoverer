module github.com/imagespy/docker_discoverer

go 1.13

require (
	github.com/docker/distribution v2.7.1+incompatible
	github.com/docker/docker v0.0.0-20180908092041-caca40c8ecfc
	github.com/docker/go-units v0.4.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/imagespy/imagespy v0.0.0-20191124180037-2cd361c87550
	github.com/morikuni/aec v1.0.0 // indirect
	github.com/opencontainers/go-digest v1.0.0-rc1 // indirect
	github.com/sirupsen/logrus v1.4.2
	google.golang.org/grpc v1.24.0 // indirect
)

replace github.com/docker/docker => github.com/docker/engine v1.4.2-0.20190822205725-ed20165a37b4
