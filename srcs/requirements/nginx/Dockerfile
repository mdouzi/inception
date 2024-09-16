FROM debian:bullseye-slim


RUN apt-get update && apt-get install -y \
    nginx \
    openssl


RUN mkdir -p /etc/nginx/ssl

COPY ./tools/script.sh /usr/local/bin/generate_ssl.sh


RUN chmod +x /usr/local/bin/generate_ssl.sh


RUN /usr/local/bin/generate_ssl.sh


COPY ./conf/nginx.conf /etc/nginx/nginx.conf


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

