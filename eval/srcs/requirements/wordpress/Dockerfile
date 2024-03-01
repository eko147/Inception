
FROM alpine:3.18

ARG PHP_VER=81 \
	DB_NAME \
    DB_USER \
    DB_PASSWORD \
    DB_HOST

RUN apk update && \
    apk --no-cache add php${PHP_VER} \
    php${PHP_VER}-fpm \
    php${PHP_VER}-phar \
    php${PHP_VER}-curl \
    php${PHP_VER}-mysqli \
    php${PHP_VER}-mbstring \
	curl \
    dumb-init

RUN	sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php${PHP_VER}/php-fpm.d/www.conf && \
	sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VER}/php-fpm.d/www.conf && \
	sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VER}/php-fpm.d/www.conf && \
	sed -i "s|;clear_env = no|clear_env = no|g" /etc/php${PHP_VER}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www/html


COPY tools/wp-create.sh /var/www/html
COPY conf/wp-config.php.sh /var/www/html

EXPOSE 9000
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp && \
	sh wp-config.php.sh && rm wp-config.php.sh


CMD ["dumb-init", "--", "/bin/sh", "wp-create.sh"]