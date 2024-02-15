# seokchoi's mariadb 참고 수정 필요
FROM alpine:3.18

# 빌드 시에 전달될 인수(argument)를 정의 /  Dockerfile 내에서 사용되는 변수를 정의하는 지시문
# 이 인수들은 컨테이너 내에서 사용할 데이터베이스 이름, 사용자 이름, 패스워드, 호스트 정보 등을 설정할 때 사용
ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_HOST

RUN apk update && \
    apk upgrade && \
	 	apk add --no-cache mariadb mariadb-client dumb-init && \
    mkdir /run/mysqld && \
    chmod 777 /run/mysqld && \
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf && \
    sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf

EXPOSE 3306

# 호스트의 tools/db-init.sh 파일을 컨테이너 내부의 /db-init.sh 경로로 복사
# 이 스크립트는 데이터베이스 초기화 및 설정을 위한 스크립트일 것으로 예상
COPY tools/db-init.sh /db-init.sh

# 이 명령은 이후의 명령들이 mysql 사용자 권한으로 실행되도록 설정

# MariaDB 컨테이너 내에서 실행되는 프로세스를 실행할 사용자를 지정 
# MariaDB 이미지는 일반적으로 'mysql' 사용자로 설정되어 있으며, 이 사용자가 MariaDB 프로세스를 실행하도록 권장

# 보안 및 권한 관리를 위해 컨테이너 내에서 특정 사용자로 프로세스를 실행하는 것이 좋은 관행입니다. 따라서 MariaDB 컨테이너의 경우, 
# MariaDB 프로세스를 실행할 사용자를 'mysql'로 지정하여 보다 안전하게 운영할 수 있습니다.
USER mysql

CMD ["dumb-init", "--", "/bin/sh", "/db-init.sh"]