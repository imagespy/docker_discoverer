module github.com/imagespy/docker_discoverer

go 1.13

require (
	github.com/docker/distribution v2.7.1+incompatible
	github.com/docker/docker v0.0.0-20180908092041-caca40c8ecfc
	github.com/docker/go-units v0.4.0 // indirect
	github.com/gogo/protobuf v1.3.0 // indirect
	github.com/imagespy/imagespy v0.0.0-20191001075332-fc870afbb1af
	github.com/morikuni/aec v1.0.0 // indirect
	github.com/opencontainers/go-digest v1.0.0-rc1 // indirect
	github.com/sirupsen/logrus v1.4.2
	golang.org/x/net v0.0.0-20190930134127-c5a3c61f89f3 // indirect
	google.golang.org/grpc v1.24.0 // indirect
)

replace github.com/docker/docker => github.com/docker/engine v1.4.2-0.20190822205725-ed20165a37b4
