VERSION ?= master

.PHONY: build
build:
	go build -mod=vendor

.PHONY: package
package:
	docker build -t imagespy/docker_discoverer:$(VERSION) .

.PHONY: release
release: package
	docker push imagespy/docker_discoverer:$(VERSION)
