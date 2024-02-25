#!/bin/sh

if [ ! -f /var/www/html/index.php ]; then

	wp core download --path=/var/www/html --locale=ko_KR --allow-root

	wp core install --url=${WORDPRESS_URL} --title=${WORDPRESS_TITLE} --allow-root --admin_user=${WORDPRESS_ADMIN_USER} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL} --path=/var/www/html --skip-email

	wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} --role=author --user_pass=${WORDPRESS_USER_PASSWORD} --allow-root
	

fi 

/usr/sbin/php-fpm81 -F