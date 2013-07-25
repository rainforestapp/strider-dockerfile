
default:
	@echo "make clone if you just want to update for a new version of strider; `make all` if you want to rebuild from scratch"

clone: base demo

all: preclone base demo

# workaround for docker push bug. Can't push multiple things that depend on each other at the same time
push-clone:
	docker tag strider/strider:latest save/me latest
	docker rmi strider/strider:latest
	docker push strider/strider
	docker tag save/me:latest strider/strider latest
	docker rmi save/me:latest
	docker push strider/strider

preclone:
	docker build -t strider/strider:preclone - < Dockerfile.preclone

base:
	docker build -t strider/strider:base - < Dockerfile.base

demo:
	docker build -t strider/strider .

vagrant:
	docker run -p 3000:3000 -p 27000:27012 -p 44:22 -d strider/strider 

# make sure the user did get added to the image
test:
	docker run jaredly/strider bash -c '/usr/bin/mongod --smallfiles --fork --logpath mongo.log; sleep 2; echo "db.users.find()" | mongo localhost/strider-foss'

