IMAGE=thzpub/nsd
VERSION=latest

manifest: i386 amd64 arm32v7 arm64v8
	docker manifest create $(IMAGE):$(VERSION) \
		$(IMAGE):i386-$(VERSION) \
		$(IMAGE):amd64-$(VERSION) \
		$(IMAGE):arm32v7-$(VERSION) \
		$(IMAGE):arm64v8-$(VERSION)
	@echo "manifest can be pushed with: docker manifest push $(IMAGE):$(VERSION)"

qemu:
	mkdir -p qemu-statics
	cp /usr/bin/qemu-arm-static qemu-statics/
	cp /usr/bin/qemu-aarch64-static qemu-statics/

define arch_build
	docker build --build-arg IMAGE_PREFIX=$(1)/ -t $(IMAGE):$(1)-$(VERSION) .
endef

i386: qemu
	$(call arch_build,i386)

amd64: qemu
	$(call arch_build,amd64)

arm32v7: qemu
	$(call arch_build,arm32v7)

arm64v8: qemu
	$(call arch_build,arm64v8)

