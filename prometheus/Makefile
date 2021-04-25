IMAGE=thzpub/prometheus

PROMVERSION=2.26.0
PKGVERSION=1

VERSION=$(PROMVERSION)-$(PKGVERSION)

ARCHS:=amd64 i386 arm32v7 arm64v8

push: $(ARCHS:%=push-%)
build: $(ARCHS:%=build-%)

push-%: build-%
	docker push $(IMAGE):$(@:push-%=%)-v$(VERSION)

# manifest command requires all references pushed to the registry
manifest: push
	docker manifest create $(IMAGE):v$(VERSION) \
		$(ARCHS:%=$(IMAGE):%-v$(VERSION))
	@echo "manifest can be pushed with: make manifest-push"

manifest-push:
	@echo "manifest can be purged with: docker manifest push --purge $(IMAGE):v$(VERSION)"
	docker manifest push $(IMAGE):v$(VERSION)

# binfmt support for cross-building docker images
qemu:
	mkdir -p qemu-statics
	cp /usr/bin/qemu-arm-static qemu-statics/
	cp /usr/bin/qemu-aarch64-static qemu-statics/

build-%: qemu
	docker build \
		--build-arg ARCH=$(@:build-%=%) \
		--build-arg PROMVERSION=$(PROMVERSION) \
		--build-arg ALPINE_PREFIX=$(@:build-%=%)/ \
		-t $(IMAGE):$(@:build-%=%)-v$(VERSION) .
