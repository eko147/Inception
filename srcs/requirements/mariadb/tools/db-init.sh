# 수정필요 주석까지 같음 
#다른 방법으로도 작성해보기

#! /bin/sh 
# 이게 뭐지

if [ ! -d "/var/lib/mysql/mysql" ]; then
        # init database
        mysql_install_db --datadir=/var/lib/mysql --user=mysql
        #이 명령어는 MariaDB 데이터베이스를 초기화하고 필요한 디렉토리와 파일을 생성합니다.
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
# 이 명령어는 Here Document를 사용하여 /tmp/create_db.sql 파일에 스크립트를 작성
# 이 스크립트는 데이터베이스를 생성하고 사용자에게 권한을 부여
        cat << EOF > /tmp/create_db.sql
USE mysql;
FLUSH PRIVILEGES;
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF
        # create_db.sql 실행 후 삭제
        # 이 명령어는 MariaDB를 시작하고 /tmp/create_db.sql 파일을 사용하여 데이터베이스와 사용자를 설정
        /usr/bin/mysqld --user=mysql --bootstrap < /tmp/create_db.sql
        # 이 명령어는 데이터베이스 설정에 사용된 임시 파일을 삭제
        rm -f /tmp/create_db.sql
fi

exec /usr/bin/mysqld --skip-log-error
# 이 명령어는 MariaDB를 실행하고 로그 파일에 오류를 기록하지 않도록 설정
#  따라서 오류가 발생하더라도 로그에 기록되지 않습니다.