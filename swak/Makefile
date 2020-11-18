IMAGE=thzpub/swak

PKGVERSION=6

VERSION=$(PKGVERSION)

build:
	docker build \
		-t $(IMAGE):$(VERSION) .

push: build
	docker push $(IMAGE):$(VERSION)
	docker tag $(IMAGE):$(VERSION) $(IMAGE):latest
	docker push $(IMAGE):latest

