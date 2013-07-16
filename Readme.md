# [Docker](http://docker.io) + [Strider](http://stridercd.com) = winning

[In the Docker Index](https://index.docker.io/u/jaredly/strider/)

-

![Strider Screenshot](http://unworkable.org/~niallo/strider3.png)

## Install the image

#### Pre-built

```bash
docker pull jaredly/strider
```

#### OR roll your own

```bash
git clone https://github.com/jaredly/strider-dockerfile.git
cd strider-docfile
make all
```

## Start it up

If you rolled your own, use `my/strider` (or whatever tag you chose) in place
of `jaredly/strider`.

#### Manual port mapping

```bash
CID=$(docker run -d -p 3000:3000 -p 27000:27017 -p 44:22 jaredly/strider)
```

So mongo is accessible on 27000, and you can ssh to port 44 on localhost.
Strider will be available on http://localhost:3000

#### OR random port assignments

```bash
CID=$(docker run -d jaredly/strider)
```

You can see what the assigned ports are by running `docker ps`.

## Enjoy your fully self-contained strider install!

```bash
google-chrome http://localhost:$(docker port $CID 3000)
```

# Security, etc.

## Setup SSH keys

The default root password is `str!der`. The following command assumes you have
an ssh key already. If not, run `ssh-keygen`. Github has a pretty good how-to
for ssh keys [here](https://help.github.com/articles/generating-ssh-keys).

```bash
ssh-copy-id "root@localhost -p $(docker port $CID 22)"
```

## Change the root password

```bash
ssh root@localhost -p $(docker port $CID 22) passwd
```

## Logs

Strider's log can be found (inside the docker container) at
`/etc/logs/supervisor/node.log`. To get at this, just ssh in.

## Supervisord

[Supervisord](http://supervisord.org/) is used to manage mongo, ssh, and
strider, taking care of their logs, and restarting them if they crash.

You can control supervisor with `supervisorctl`, which again would be through ssh

```bash
ssh root@localhost -p $(docker port [containerid] 22) supervisorctl
```

More info at http://supervisord.org/running.html#running-supervisorctl

# Roll your own

`jaredly/strider:base` gives you a great starting point with all of the
necessary packages for running strider, while also giving you the power to:

- add custom strider extensions
- set the default root password & admin user information
- use an external mongo server
- set ENV variables for strider
- do whatever you want, really.

Just grab this repo, make whatever changes you like to the `custom/Dockerfile`,
and `custom/supervisord.conf` and build!

```bash
cd custom
docker build -t my/strider .
```

# Questions, thoughts, concerns

Please use the github issues to ask any questions or make suggestions.

# License

MIT

