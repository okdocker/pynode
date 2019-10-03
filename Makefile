DOCKER ?= $(shell which docker)
ROCKER ?= $(shell [ -x $(GOPATH)/bin/rocker ] && echo $(GOPATH)/bin/rocker || which rocker)
ROCKER_OPTIONS ?=
PYTHON_VERSION ?= 3.7
NODE_VERSION ?= 10
VERSION ?= $(PYTHON_VERSION)-$(NODE_VERSION)
DOCKER_IMAGE ?= okdocker/pynode:$(VERSION)

.PHONY = build push

all: build-lts build-current

build:
	$(ROCKER) build -f Rockerfile --attach $(ROCKER_OPTIONS) -var DockerImage=$(DOCKER_IMAGE) -var PythonVersion=$(PYTHON_VERSION) -var NodeVersion=$(NODE_VERSION) .

build-current:
	NODE_VERSION=12 $(MAKE) build

build-lts:
	NODE_VERSION=10 $(MAKE) build

shell: build
	$(DOCKER) run -it --rm $(DOCKER_IMAGE) bash
