
all:
	docker -t jaredly/strider:preclone - < Dockerfile.preclone
	docker -t jaredly/strider:base - < Dockerfile.base
	docker -t jaredly/strider:mongo - < Dockerfile.mongo
	docker -t jaredly/strider .
