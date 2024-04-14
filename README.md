# pgaw
This is a resilient database server providing the Adventureworks database
running on postgresql.

## Useful resources
https://kbroman.org/github_tutorial/ = clearly written guide helped jog the
memory about getting git working

https://docs.nginx.com/nginx/admin-guide/load-balancer/http-load-balancer/#method
= adding option 3 "ip_hash;" into nginx config was crucial in getting
session persistence working (pgadmin was not working once moved to 
multiple containers without this, which is all fairly obvious in 
hindsight)

https://docs.gunicorn.org/en/latest/deploy.html = shows how to deploy a
gunicorn app behind nginx complete with detailed example config file
