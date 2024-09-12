# Use the official Debian-based Nginx image as a base
FROM debian:bullseye-slim

# Install necessary packages
RUN apt-get update && apt-get install -y \
    nginx \
    openssl

# Create a directory to store SSL certificates
RUN mkdir -p /etc/nginx/ssl

# Copy the script to generate SSL certificates
COPY ./tools/script.sh /usr/local/bin/generate_ssl.sh

# Make the script executable
RUN chmod +x /usr/local/bin/generate_ssl.sh

# Run the script to generate SSL certificates
RUN /usr/local/bin/generate_ssl.sh

# Copy Nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose port 443 for HTTPS
EXPOSE 443

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

