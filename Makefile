
default:
	@echo "choose a target"

clone: base demo

all: preclone base demo

preclone:
	docker build -t jaredly/strider:preclone - < Dockerfile.preclone

base:
	docker build -t jaredly/strider:base - < Dockerfile.base

demo:
	docker build -t jaredly/strider .
