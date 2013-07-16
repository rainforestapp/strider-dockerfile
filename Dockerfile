# DOCKER-VERSION 0.4.8

from  jaredly/strider:mongo

# 27017 is your local mongodb instance
# 22 is ssh server
# 3000 is strider
# You can find out what ports they are mapped to on your host by running `docker ps`
expose  27017 22 3000

# supervisord will run mongo, ssh, and strider, and restart them if they crash
cmd  ["/usr/bin/supervisord", "-n"]

# Add an admin user
run  /src/bin/strider addUser --email test@example.com --password dontlook --admin true

# Root password
run  echo 'root:str!der' | chpasswd

add  supervisord.conf /etc/supervisor/conf.d/supervisord.conf
