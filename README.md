# pgaw
This is a resilient server providing the Adventureworks database
running on postgres in Docker.

I had a need for an SQL server that users could use to practise writing
queries. Having previously used pgadmin for this puprose I found that, 
whilst it is an excellent tool, it can eat up memory and ultimately OOM
the server, especially if a user writes a query which returns an
unusually large result set, often by accident as they are experimenting.

Building a containerised solution using Docker should be able to mitigate
this. I also wanted to gain some more experience playing around with Docker
and Compose.

## Prerequesites

This is an overview of the steps taken to set up this project.

### Host config

The following commands setup the host (a Raspberry Pi 4).

```
sudo apt update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
sudo apt install docker-compose-plugin git
git clone https://github.com/cp2423/pgaw.git
```

By default RPi OS does not have "cgroup memory" enabled so following
[this forum post](https://forums.raspberrypi.com/viewtopic.php?t=203128)
`/boot/firmware/cmdline.txt` was updated to the following:
```
console=serial0,115200 console=tty1 root=PARTUUID=28ffafa1-02 rootfstype=ext4 fsck.repair=yes rootwait cfg80211.ieee80211_regdom=GB cgroup_enable=cpuset cgroup_enable=memory
```


### Database

A postgres version of the Adventureworks database is available here: 
https://github.com/NorfolkDataSci/adventure-works-postgres

As noted on the issues page, this does not work straight out of the box
because there are some inconsistent paths used in the SQL which copies
in CSV files from the data folder - some are missing the data/ prefix.
This was addressed by using `sed` to add in the missing prefix as required.

## Docker

There are three images used:

1. nginx for reverse proxy and load balancer
2. pgadmin image to provide the backend web servers
3. postgres to provide the database

These are glued together using docker compose, namely `compose.yaml` which
is used by doing:
```
docker compose up
```

### nginx config notes

A major stumbling block was getting load balancing to work. It took me
longer than it should have done to realise that pgadmin needed
session persistence to work propely (an initial Google search had
suggested that this was not going to work at all but that was not 
the case in the end).

The key was adding `ip_hash;` as the documentation (link below)
explains this ensures requests from the same source are routed
to the same backend instance.

## Useful resources
https://kbroman.org/github_tutorial/ = clearly written guide helped jog the
memory about getting git working

https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/#method
= adding option 3 "ip_hash;" into nginx config was crucial

https://docs.gunicorn.org/en/latest/deploy.html = shows how to deploy a
gunicorn app behind nginx complete with detailed example config file

https://github.com/docker/awesome-compose/tree/master = examples of docker
configs for various apps eg used nginx-flask-mysql as jumping off point for
this project
