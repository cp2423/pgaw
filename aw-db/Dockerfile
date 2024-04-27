FROM postgres:16.2
# script to create new db and user in postgres
COPY init.sh /docker-entrypoint-initdb.d/init.sh
# copy in csv files and script to copy data in
COPY data /var/data
COPY install.sql /var/data/install.sql
# required to make the above script work
WORKDIR /var
