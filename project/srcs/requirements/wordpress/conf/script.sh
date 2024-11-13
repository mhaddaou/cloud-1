#!/bin/bash

cd /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

#This command will create a new wp-config.php
wp core config --dbhost=$MYSQL_HOST \
                --dbname=$MYSQL_DATABASE \
                --dbuser=$MYSQL_USER \
                --dbpass=$MYSQL_PASSWORD \
                --allow-root
#before use this command you will need to have a wordpress database configured
wp core install --title=$WORDPRESS_NAME \
                --admin_user=$WORDPRESS_ROOT_LOGIN \
                --admin_password=mhaddaou1337 \
                --admin_email=$WORDPRESS_ROOT_EMAIL \
                --url=$DOMAIN_NAME \
                --allow-root

wp user create $MYSQL_USER $WORDPRESS_USER_EMAIL --role=author --user_pass=$MYSQL_PASSWORD --allow-root

# wp option update WP_ALLOW_REPAIR true
wp config set WP_ALLOW_REPAIR "true" --allow-root
# is used to enable the WordPress object cache
wp config set WP_CACHE --raw "true" --allow-root
# the file /var/run/php/ will be created automatically when you run php service
service php7.3-fpm start

# i Stop php cause the next command cannot use the port 9000
service php7.3-fpm stop

php-fpm7.3 -F

