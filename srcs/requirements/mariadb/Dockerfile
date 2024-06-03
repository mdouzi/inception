# pull base image

FROM debian::buster

#update and upgrade the system

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server


COPY ./conf/create_db.sh /create_db.sh

RUN chmod +x /create_db.sh

ENTRYPOINT [ "./create_db.sh" ]
