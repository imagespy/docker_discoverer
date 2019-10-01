VERSION ?= master
IMAGE = quay.io/imagespy/docker-discoverer

.PHONY: build
build:
	go build -mod=vendor

.PHONY: package
package:
	docker build -t $(IMAGE):$(VERSION) .

.PHONY: release
release: package
	docker push $(IMAGE):$(VERSION)
