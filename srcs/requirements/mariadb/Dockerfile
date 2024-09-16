# Description: MariaDB Dockerfile

# pull base image
FROM debian:bullseye


RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server


COPY ./conf/create_db.sh /mdb-conf.sh


RUN chmod +x /mdb-conf.sh


ENTRYPOINT ["./mdb-conf.sh"]