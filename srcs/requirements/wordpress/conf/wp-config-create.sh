#!/bin/bash

#---------------------------------------------------#
#                  WP-CLI Installation              #
#---------------------------------------------------#

# Download wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

#---------------------------------------------------#
#          WordPress Directory Permissions          #
#---------------------------------------------------#

# Navigate to the WordPress directory
cd /var/www/wordpress

# Set correct ownership and permissions for WordPress directory
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

#---------------------------------------------------#
#            Waiting for MariaDB to Start           #
#---------------------------------------------------#

# Function to check MariaDB status
check_mariadb() {
    for i in {1..30}; do
        if nc -z mariadb 3306; then
            echo "[SUCCESS] MariaDB is accepting connections on port 3306. Proceeding with WordPress installation..."
            return 0
        fi
        echo "[INFO] Attempt $i: MariaDB is not ready yet. Waiting for 1 second before retrying..."
        sleep 1
    done
    echo "[ERROR] MariaDB did not become available within 20 seconds. Please check the MariaDB container logs for more details."
    exit 1
}



# Call the function
check_mariadb

#---------------------------------------------------#
#               WordPress Installation              #
#---------------------------------------------------#

# Download the core WordPress files
wp core download --allow-root

# Create the wp-config.php file with database credentials
wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root

# Install WordPress with the given details
wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root

# Create a new user with specified credentials and role
wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root

#---------------------------------------------------#
#              PHP-FPM Configuration                #
#---------------------------------------------------#

# Update PHP-FPM configuration to listen on port 9000 instead of a Unix socket
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf

# Create the required directory for PHP-FPM
mkdir -p /run/php

# Start PHP-FPM in the foreground
/usr/sbin/php-fpm7.4 -F
