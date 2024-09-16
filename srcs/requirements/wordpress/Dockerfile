FROM debian:bullseye


RUN apt-get update && apt-get upgrade -y


RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client netcat sendmail


COPY ./conf/wp-config-create.sh /


RUN  chmod +x wp-config-create.sh


ENTRYPOINT ["./wp-config-create.sh"]