# 
#다른 방법으로도 작성해보기

#! /bin/sh
# 이게 뭐지

# MariaDB 컨테이너가 시작될 때 실행되며, 데이터베이스의 초기 상태를 설정하는 데 사용됩니다.
# 데이터베이스 서버

#MariaDB 컨테이너는 데이터베이스를 호스팅하고, Nginx 컨테이너는 웹 서버로서의 역할을 수행합니다. 따라서 웹 서버와 데이터베이스 서버를 분리하여 각각의 역할에 최적화된 환경을 구성하는 것이 일반적으로 더 안전하고 효율적

#nginx를 사용하지 말란것은 각 컨테이너가 자신의 역할에 집중하고 서로의 역할을 침범하지 않도록 하는 것을 의미

if [ ! -d  "/var/lib/mysql/mysql" ]; then
        mysql_install_db --user=mysql --datadir=/var/lib/mysql
        #이 명령어는 MariaDB 데이터베이스를 초기화하고 필요한 디렉토리와 파일을 생성합니다.
fi

if [ ! -d "/var/lib/mysql/wordpress" ]; then
# 이 명령어는 Here Document를 사용하여 /tmp/create_db.sql 파일에 스크립트를 작성
# 크리에이트 디비란 .. 이 밑의 내용을 여기에 담겠다는것
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
        # 실행을 했으니 삭제 
        rm -f /tmp/create_db.sql
fi

exec /usr/bin/mysqld --skip-log-error
# 이 명령어는 MariaDB를 실행하고 로그 파일에 오류를 기록하지 않도록 설정
#  따라서 오류가 발생하더라도 로그에 기록되지 않습니다.
# mysqld 실행 하겠다



# 1. **`USE mysql;`**: mysql 데이터베이스를 선택합니다. 이 명령은 현재 세션에서 사용할 데이터베이스를 mysql로 변경합니다.
# 2. **`FLUSH PRIVILEGES;`**: 데이터베이스 사용자 권한을 새로 고치기 위해 권한 캐시를 재로딩합니다.
# 3. **`DROP DATABASE test;`**: test라는 이름의 데이터베이스를 삭제합니다.→ test 데이터베이스는 기본으로 생기고 필요없기 때문에 지워주는 것이 좋다.
# 4. **`DELETE FROM mysql.db WHERE Db='test';`**: test 데이터베이스에 관련된 권한 정보를 mysql.db 테이블에서 삭제합니다.
# 5. **`DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');`**: root 사용자에 대한 호스트가 'localhost', '127.0.0.1', '::1'이 아닌 경우의 권한 정보를 mysql.user 테이블에서 삭제합니다. → 보안상의 이유로 로컬호스트가 아닌 경우에는 user=root로 접근하지 못하도록 하는 것이다. 여기서 ::1은 IPv6에서 루프백 주소를 나타내기 때문에 추가한거라고 보면 될 것 같다.
# 6. **`ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';`**: root 사용자의 암호를 **`${DB_ROOT_PASSWORD}`** 변수 값으로 변경합니다.
# 7. **`CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;`**: **`${DB_NAME}`** 변수 값으로 데이터베이스를 생성합니다. 문자셋과 collation도 설정합니다. → Collation(콜레이션)은 데이터베이스 내에서 문자열 비교 및 정렬을 수행할 때 사용되는 문자열 정렬 규칙의 집합입니다.
# 8. **`CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASSWORD}';`**: **`${DB_USER}`** 변수 값으로 사용자를 생성합니다. 이 사용자는 어떤 호스트로부터의 연결도 허용합니다. ⇒ % 는 모든 호스트라는 뜻으로 모든 호스타가 DB_USER에 접속할 수 있다는 뜻이다. 
# 9. **`GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';`**: **`${DB_USER}`** 사용자에게 wordpress 데이터베이스에 대한 모든 권한을 부여합니다.
# 10. **`FLUSH PRIVILEGES;`**: 데이터베이스 사용자 권한을 새로 고치기 위해 권한 캐시를 재로딩합니다.