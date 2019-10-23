IMAGE=thzpub/psql-backup

RETAINVERSION=1.1.0
PKGVERSION=4

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
define manifest_create
	docker manifest create $(1) \
		$(IMAGE):i386-$(VERSION) \
		$(IMAGE):amd64-$(VERSION) \
		$(IMAGE):arm32v7-$(VERSION) \
		$(IMAGE):arm64v8-$(VERSION)
	docker manifest annotate $(1) $(IMAGE):i386-$(VERSION)    --os=linux --arch=386
	docker manifest annotate $(1) $(IMAGE):amd64-$(VERSION)   --os=linux --arch=amd64
	docker manifest annotate $(1) $(IMAGE):arm32v7-$(VERSION) --os=linux --arch=arm
	docker manifest annotate $(1) $(IMAGE):arm64v8-$(VERSION) --os=linux --arch=arm64
endef
manifest: push
	$(call manifest_create,$(IMAGE):$(VERSION))
	$(call manifest_create,$(IMAGE):latest)
	@echo "manifest can be purged with: make manifest-purge"
	@echo "manifest can be pushed with: make manifest-push"
manifest-push:
	docker manifest push $(IMAGE):$(VERSION)
	docker manifest push $(IMAGE):latest
manifest-purge:
	docker manifest push --purge $(IMAGE):$(VERSION)
	docker manifest push --purge $(IMAGE):latest

# binfmt support for cross-building docker images
qemu:
	mkdir -p qemu-statics
	cp /usr/bin/qemu-arm-static qemu-statics/
	cp /usr/bin/qemu-aarch64-static qemu-statics/

