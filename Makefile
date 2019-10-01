VERSION ?= master

.PHONY: build
build:
	go build -mod=vendor

.PHONY: package
package:
	docker build -t quay.io/imagespy/docker-discoverer:$(VERSION) .

.PHONY: release
release: package
	docker push quay.io/imagespy/docker-discoverer:$(VERSION)
