IMAGE:=thzpub/scratch
VERSION:=latest
ARCHS:=amd64 i386 arm32v6 arm32v7 arm64v8

push: $(ARCHS:%=push-%)
build: $(ARCHS:%=build-%)

build-%:
	docker build -t $(IMAGE):$(@:build-%=%)-$(VERSION) .

push-%: build-%
	docker push $(IMAGE):$(@:push-%=%)-$(VERSION)

manifest: push
	@echo "manifest can be purged with: docker manifest push --purge $(IMAGE):$(VERSION)"
	docker manifest create $(IMAGE):$(VERSION) \
		$(ARCHS:%=$(IMAGE):%-$(VERSION))
	docker manifest annotate \
		--os linux --arch 386  $(IMAGE):$(VERSION) $(IMAGE):i386-$(VERSION)
	docker manifest annotate \
		--os linux --arch arm64 --variant v8 $(IMAGE):$(VERSION) $(IMAGE):arm64v8-$(VERSION)
	docker manifest annotate \
		--os linux --arch arm --variant v6 $(IMAGE):$(VERSION) $(IMAGE):arm32v6-$(VERSION)
	docker manifest annotate \
		--os linux --arch arm --variant v7 $(IMAGE):$(VERSION) $(IMAGE):arm32v7-$(VERSION)

manifest-push:
	docker manifest push $(IMAGE):$(VERSION)

