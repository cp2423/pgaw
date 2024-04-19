FROM postgres:16.2
COPY init.sh /docker-entrypoint-initdb.d/init.sh
COPY data /var/data
COPY install.sql /var/data/install.sql
WORKDIR /var
