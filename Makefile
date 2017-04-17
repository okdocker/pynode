DOCKER ?= $(shell which docker)
ROCKER ?= $(shell [ -x $(GOPATH)/bin/rocker ] && echo $(GOPATH)/bin/rocker || which rocker)
ROCKER_OPTIONS ?= 
PYTHON_VERSION ?= 3.6
NODE_VERSION ?= 6
VERSION ?= $(PYTHON_VERSION)-$(NODE_VERSION)
DOCKER_IMAGE ?= okdocker/pynode:$(VERSION)

.PHONY = build push

build:
	$(ROCKER) build -f Rockerfile --attach $(ROCKER_OPTIONS) -var DockerImage=$(DOCKER_IMAGE) .

push:
	ROCKER_OPTIONS=--push make build

shell: build
	$(DOCKER) run -it --rm $(DOCKER_IMAGE) bash
