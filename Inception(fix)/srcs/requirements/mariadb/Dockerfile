FROM alpine:3.18

RUN apk update && apk upgrade && \
	apk add --no-cache mariadb-client dumb-init mariadb && \
    mkdir /run/mysqld && \
    chmod 777 /run/mysqld && \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf && \
    sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

COPY tools/db-set.sh /db-set.sh

USER mysql

CMD ["dumb-init", "--", "/bin/sh", "/db-set.sh"]