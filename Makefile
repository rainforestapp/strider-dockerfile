
all: preclone base mongo demo

preclone:
	docker build -t jaredly/strider:preclone - < Dockerfile.preclone

base:
	docker build -t jaredly/strider:base - < Dockerfile.base

mongo:
	docker build -t jaredly/strider:mongo - < Dockerfile.mongo

demo:
	docker build -t jaredly/strider .
