
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

# make sure the user did get added to the image
test:
	docker run jaredly/strider bash -c '/usr/bin/mongod --smallfiles --fork --logpath mongo.log; sleep 2; echo "db.users.find()" | mongo localhost/strider-foss'
