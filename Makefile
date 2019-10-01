.PHONY: build
build:
	go build -mod=vendor

package:
	docker build -t imagespy/docker_discoverer .
