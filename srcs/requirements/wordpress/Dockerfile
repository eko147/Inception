# # 수정 필요

# FROM alpine:3.18

# ARG PHP_VERSION=81 \
# 	DB_NAME \
#     DB_USER \
#     DB_PASSWORD \
#     DB_HOST

# RUN apk update && \
# 	apk upgrade && \
# 	apk add --no-cache \
# 	# 플래그를 사용하여 패키지 설치 후 캐시를 지우므로, 이미지 크기를 줄일 수 있습니다
# 	php${PHP_VERSION} \
# 	# 지정된 PHP 버전을 설치
# 	php${PHP_VERSION}-fpm \
# 	#PHP-FPM은 PHP FastCGI 프로세스 매니저로, 웹 서버와 PHP 어플리케이션 사이의 통신을 처리

# 	#기타 PHP 확장 기능들: JSON, cURL, MySQLi, MySQLnd, 세션, 아이콘브, 파일 인포, XML 리더, 문자 형식 변환, PDO, PDO MySQL, Phar
# 	php${PHP_VERSION}-json \
# 	php${PHP_VERSION}-curl \
# 	php${PHP_VERSION}-mysqli \
# 	php${PHP_VERSION}-mysqlnd \
# 	php${PHP_VERSION}-session \
# 	php${PHP_VERSION}-json \
# 	php${PHP_VERSION}-iconv \
# 	php${PHP_VERSION}-fileinfo \
# 	php${PHP_VERSION}-xmlreader \
# 	php${PHP_VERSION}-ctype \
# 	php${PHP_VERSION}-pdo \
# 	php${PHP_VERSION}-pdo_mysql \
# 	php${PHP_VERSION}-phar \
	
# 	#wget, unzip, curl: 다양한 웹 리소스를 다운로드하고 압축을 해제하는 데 사용되는 도구
# 	#iputils: 네트워크 유틸리티 패키지로, 네트워크 연결을 확인하고 테스트하는 데 사용됩니다.
# 	#tini: 부모 및 자식 프로세스 간의 시그널을 관리하는 작은 유틸리티입니다.
# 	wget \
# 	unzip \
# 	curl \
# 	iputils \
# 	tini && \
# 	sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
# 	# PHP-FPM이 모든 네트워크 인터페이스에서 요청을 수락하도록 리스닝 주소를 변경
# 	sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
# 	# PHP-FPM 프로세스가 실행될 사용자를 nobody로 설정
# 	sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
# 	# PHP-FPM 프로세스가 실행될 그룹을 nobody로 설정합니다.
# 	sed -i "s|;clear_env = no|clear_env = no|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
# 	# PHP-FPM에서 환경 변수를 클리어하지 않도록 설정
#     rm -f /var/cache/apk/*
# 	# APK 패키지 캐시를 삭제하여 이미지 크기를 최적화

# WORKDIR /var/www/html
# # 이 명령은 작업 디렉토리를 /var/www/html로 설정, 이 디렉토리는 일반적으로 웹 서버가 정적 및 동적 콘텐츠를 호스팅하는 디렉토리

# COPY conf/wp-config.php.sh /var/www/html
# COPY tools/wp-install.sh /var/www/html
# # 이 두 명령은 호스트 시스템에서 이미 존재하는 wp-config.php.sh와 wp-install.sh 스크립트 파일을 Docker 이미지의 /var/www/html 디렉토리로 복사
# # 이들 스크립트는 WordPress 설정 파일을 생성하고 WordPress를 설치하는 데 사용

# EXPOSE 9000
# # 이 명령은 Docker 컨테이너가 호스트 시스템에 노출할 포트를 설정
# # 여기서는 PHP-FPM이 사용하는 9000번 포트를 노출

# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
# # 이 명령은 워드프레스를 관리하기 위한 WP-CLI(Command Line Interface)를 다운로드합니다. 다운로드한 wp-cli.phar 파일은 현재 디렉토리에 저장

# 	chmod +x wp-cli.phar && \
# 	# 다운로드한 wp-cli.phar 파일에 실행 권한을 부여

# 	mv wp-cli.phar /usr/local/bin/wp
# 	# wp-cli.phar 파일을 /usr/local/bin 디렉토리로 이동하여 실행 가능한 wp 명령어로 만듭니다

# RUN sh wp-config.php.sh && rm wp-config.php.sh
# # 스크립트를 실행하여 WordPress 설정 파일을 생성 그 후에는 더 이상 필요하지 않으므로 삭제

# CMD ["tini", "--", "/bin/sh", "wp-install.sh"]
# # 컨테이너가 시작될 때 실행되는 명령을 지정
# # 여기서는 tini를 통해 /bin/sh wp-install.sh 스크립트를 실행하여 WordPress를 설치
# # tini는 부모 및 자식 프로세스 간의 시그널을 관리하는 작은 유틸리티이며, wp-install.sh 스크립트는 WordPress를 설치하는 작업을 수행

FROM alpine:3.18

ARG PHP_VERSION=81 \
	DB_NAME \
    DB_USER \
    DB_PASSWORD \
    DB_HOST

RUN apk update && \
	apk upgrade && \
	apk add --no-cache \
	php${PHP_VERSION} \
	php${PHP_VERSION}-fpm \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-curl \
	php${PHP_VERSION}-mysqli \
	php${PHP_VERSION}-mysqlnd \
	php${PHP_VERSION}-session \
	php${PHP_VERSION}-json \
	php${PHP_VERSION}-iconv \
	php${PHP_VERSION}-fileinfo \
	php${PHP_VERSION}-xmlreader \
	php${PHP_VERSION}-ctype \
	php${PHP_VERSION}-pdo \
	php${PHP_VERSION}-pdo_mysql \
	php${PHP_VERSION}-phar \
	wget \
	unzip \
	curl \
	iputils \
	tini && \
	sed -i "s|listen = 127.0.0.1:9000|listen = 0.0.0.0:9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
	sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
	sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
	sed -i "s|;clear_env = no|clear_env = no|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

WORKDIR /var/www/html

COPY conf/wp-config.php.sh /var/www/html
COPY tools/wp-install.sh /var/www/html

EXPOSE 9000

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN sh wp-config.php.sh && rm wp-config.php.sh

CMD ["tini", "--", "/bin/sh", "wp-install.sh"]