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

Key lessons:
- **Docker Compose** in particular lifecycle of a container eg effect of
`up`, `down`, `down -v` (which will remove volumes too which was necessary
to recreate the database) also faffing around with replicas and secrets
- **Architecture** making nginx load balancing work across a Docker network

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

The `Dockerfile` for nginx simply copies the config file from the db
directory into the container.

### pgadmin config notes

Really the whole point of this exercise was to practise building a
"resilient" server using Docker since previous experience of 
pgadmin has shown that a large and/or poorly written query can
cause this to eat up all the memory leading to OOM and a dead 
server.

I believed that Docker could be used to mitigtate for this by:

1. having mutliple pgadmin containers to spread the load
2. limiting the amount of memory each pgadmin could use and
which would cauase that single instance to die gracefully
without taking down the server with it.

The first part was simple using the `replicas` instruction in
compose to create three identical pgadmin containers. By having
multiple instances, if one dies, the others continue so only the
user(s) contected to the dead instance will be affected as it
resurrects itself.

Getting memory limits to work was challenging, firstly 
because of `cgroups` being disabled in the OS (see above).
Then there was some confusion over wether the compose 
settings for memory limits now only apply to docker swarm.
In the end, using lowercase `m` to signify megabytes in
the compose file seemed to make all the difference. This
can be tested by running `docker stats` in parallel when 
the containers are up, which clearly shows the maximum 
amount of memory each container is allowed.

### postgres config notes

The [release notes](https://hub.docker.com/_/postgres) of the
postgres docker image clearly explain the ways in which it 
can be used. Here an init script is used to make sure that 
a new user and then the data is added to the Adventureworks
database.

This image is smart. On first run, it runs the init script
and creates the database, which takes a little while. On future
runs if it sees a database is already present in the mounted 
volume these steps are skipped, thus providing persistence.

## SSL support

Adding SSL support was a challenge. I made this much more difficult
than it needed to be by insisting that the key file
be stored in a completely separate directory to avoid it accidentally
being pushed into GitHub. I updated `.gitignore` to exclude `*.key`
but I wanted to learn a "belt and braces" approach using Docker secrets.

Note that Docker ignores symlinks since they argue these would create a
container which is not perfectly replicable which is sort of 
understandable I guess.

A key lesson was that some features of compose files are *only* valid
when running Docker in swarm mode - in particular 
[setting uid, gid and mode on a secret](https://github.com/docker/compose/issues/9648)
is not a thing in Docker Compose. This matters because postgres
requires either the postgres user or root to own the key file.

The solution was to `chown` the key file on the host as Docker Compose
copies across the ownership etc when running on Linux.

## Useful resources
https://kbroman.org/github_tutorial/ clearly written guide helped jog the
memory about getting git working

https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/#method
adding option 3 "ip_hash;" into nginx config was crucial

https://docs.gunicorn.org/en/latest/deploy.html shows how to deploy a
gunicorn app behind nginx complete with detailed example config file

https://github.com/docker/awesome-compose/tree/master examples of docker
configs for various apps eg used nginx-flask-mysql as jumping off point for
this project
