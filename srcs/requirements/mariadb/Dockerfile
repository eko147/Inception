
FROM alpine:3.18

# 빌드 시에 전달될 인수(argument)를 정의 /  Dockerfile 내에서 사용되는 변수를 정의하는 지시문
# 이 인수들은 컨테이너 내에서 사용할 데이터베이스 이름, 사용자 이름, 패스워드, 호스트 정보 등을 설정할 때 사용
ARG DB_NAME \
    DB_USER \
    DB_PASS \
    DB_HOST

RUN apk update && \
# 이 명령은 Alpine Linux 패키지 관리자의 패키지 색인을 업데이트 이를 통해 사용 가능한 최신 버전의 소프트웨어 패키지를 확인할 수 있다
    apk upgrade && \
# 이 명령은 현재 시스템에 설치된 모든 패키지를 최신 버전으로 업그레이드 새로운 버전의 패키지를 설치하고 이전 버전의 패키지를 제거
	 	apk add --no-cache mariadb mariadb-client dumb-init && \
# 이 명령은 Mariadb 데이터베이스 서버와 클라이언트를 설치하고, 또한 초기화 및 프로세스 관리를 위해 dumb-init을 설치 --no-cache 옵션은 패키지를 다운로드할 때 캐시를 사용하지 않도록 합니다.
    mkdir /run/mysqld && \
# 이 명령은 MariaDB가 실행 중인 동안에 사용될 디렉터리를 생성합니다. 일반적으로 MariaDB는 이 디렉터리를 소켓 및 기타 임시 파일을 저장하는 데 사용
    chmod 777 /run/mysqld && \
# 이 명령은 /run/mysqld 디렉터리에 모든 사용자에게 읽기, 쓰기 및 실행 권한을 부여 이는 MariaDB 프로세스가 해당 디렉터리에 대한 액세스 권한을 가질 수 있도록한다
    sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf && \
# 이 명령은 MariaDB 설정 파일인 mariadb-server.cnf에서 skip-networking 옵션을 찾아서 해당 값을 0으로 변경 이를 통해 MariaDB가 네트워크 연결을 허용하도록 설정
    sed -i "s/#bind-address=0.0.0.0/bind-address=0.0.0.0/g" /etc/my.cnf.d/mariadb-server.cnf
#  이 명령은 MariaDB 설정 파일에서 주석 처리된 bind-address 옵션을 찾아서 주석 처리를 제거하고, 주소를 0.0.0.0으로 변경 이는 MariaDB가 모든 네트워크 인터페이스에서 연결을 수락하도록 설정

EXPOSE 3306

# 호스트의 tools/db-init.sh 파일을 컨테이너 내부의 /db-init.sh 경로로 복사
# 이 스크립트는 데이터베이스 초기화 및 설정을 위한 스크립트일 것으로 예상
COPY tools/db-init.sh /db-init.sh
# 명령은 Docker 이미지 내부에 있는 파일을 복사하는 역할 이 경우 tools 디렉토리에 있는 db-init.sh 파일을 Docker 이미지의 루트 디렉토리에 있는 db-init.sh로 복사

# 이 명령은 이후의 명령들이 mysql 사용자 권한으로 실행되도록 설정

# MariaDB 컨테이너 내에서 실행되는 프로세스를 실행할 사용자를 지정 
# MariaDB 이미지는 일반적으로 'mysql' 사용자로 설정되어 있으며, 이 사용자가 MariaDB 프로세스를 실행하도록 권장

# 보안 및 권한 관리를 위해 컨테이너 내에서 특정 사용자로 프로세스를 실행하는 것이 좋은 관행입니다. 따라서 MariaDB 컨테이너의 경우, 
# MariaDB 프로세스를 실행할 사용자를 'mysql'로 지정하여 보다 안전하게 운영할 수 있습니다.
USER mysql

CMD ["dumb-init", "--", "/bin/sh", "/db-init.sh"]