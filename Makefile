ROCKER ?= $(shell [ -x $(GOPATH)/bin/rocker ] && echo $(GOPATH)/bin/rocker || which rocker)
ROCKER_OPTIONS ?= 

.PHONY = build push

build:
	$(ROCKER) build -f Rockerfile --attach $(ROCKER_OPTIONS) .

push:
	ROCKER_OPTIONS=--push make build
