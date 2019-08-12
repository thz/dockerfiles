IMAGE=thzpub/psql-backup

RETAINVERSION=1.0.0
PKGVERSION=2

VERSION=v$(PKGVERSION)

ARCHS:=amd64 i386 arm32v7 arm64v8

build: $(ARCHS:%=build-%)
push: $(ARCHS:%=push-%)

build-%: qemu
	docker build \
		--build-arg ARCH=$(@:build-%=%) \
		--build-arg RETAINVERSION=$(RETAINVERSION) \
		--build-arg ARCH_PREFIX=$(@:build-%=%)/ \
		-t $(IMAGE):$(@:build-%=%)-$(VERSION) .

push-%: build-%
	docker push $(IMAGE):$(@:push-%=%)-$(VERSION)

# manifest command requires all references pushed to the registry
manifest: push
	docker manifest create $(IMAGE):$(VERSION) \
		$(ARCHS:%=$(IMAGE):%-$(VERSION))
	@echo "manifest can be pushed with: make manifest-push"

manifest-push:
	@echo "manifest can be purged with: docker manifest push --purge $(IMAGE):$(VERSION)"
	docker manifest push $(IMAGE):$(VERSION)

# binfmt support for cross-building docker images
qemu:
	mkdir -p qemu-statics
	cp /usr/bin/qemu-arm-static qemu-statics/
	cp /usr/bin/qemu-aarch64-static qemu-statics/

