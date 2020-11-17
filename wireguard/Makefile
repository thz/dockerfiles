IMAGE=thzpub/wireguard
VERSION=1.0.0

ARCHS:=amd64 i386 arm32v7 arm64v8

push: $(ARCHS:%=push-%)
build: $(ARCHS:%=build-%)

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

build-%: qemu
	docker build --build-arg IMAGE_PREFIX=$(@:build-%=%)/ -t $(IMAGE):$(@:build-%=%)-$(VERSION) .
