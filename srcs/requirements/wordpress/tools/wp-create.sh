#!/bin/sh

# 이미지가 빌드되고 난 후 동작시킬애들
# 수정필요

if [ ! -f /var/www/html/index.php ]; then
# 만약 /var/www/html/index.php 파일이 존재하지 않는다면 아래의 명령을 실행
# 즉, WordPress가 아직 설치되지 않았을 때만 아래의 명령이 실행

	wp core download --path=/var/www/html --locale=ko_KR --allow-root
	# WP-CLI를 사용하여 WordPress 코어 파일을 다운로드
	# --path 옵션으로 WordPress를 설치할 디렉토리를 지정하고, --locale 옵션으로 한국어로 설정합니다.

	# root는 관리자 
	wp core install --url=${WORDPRESS_URL} --title=${WORDPRESS_TITLE} --allow-root --admin_user=${WORDPRESS_ADMIN_USER} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL} --path=/var/www/html --skip-email
	# WP-CLI를 사용하여 WordPress를 설치
	# 필요한 정보를 환경 변수로부터 받아와서 WordPress를 설정
	# ${WORDPRESS_URL}은 웹 사이트의 URL, ${WORDPRESS_TITLE}은 웹 사이트의 제목, ${WORDPRESS_ADMIN_USER}는 관리자 사용자 이름, ${WORDPRESS_ADMIN_PASSWORD}는 관리자 비밀번호, ${WORDPRESS_ADMIN_EMAIL}은 관리자 이메일 주소 
	# --skip-email 옵션은 이메일 설정을 건너뛴다

	wp user create ${WORDPRESS_USER} ${WORDPRESS_USER_EMAIL} --role=author --user_pass=${WORDPRESS_USER_PASSWORD} --allow-root
	# WP-CLI를 사용하여 새로운 사용자를 생성
	# ${WORDPRESS_USER}는 새로운 사용자의 이름, ${WORDPRESS_USER_EMAIL}는 새로운 사용자의 이메일 주소, ${WORDPRESS_USER_PASSWORD}는 새로운 사용자의 비밀번호
	# 이 사용자는 'author' 역할을 가집니다.
	

fi 
# fi는 셸 스크립트에서 조건문의 끝을 나타내는 키워드

/usr/sbin/php-fpm81 -F
# PHP-FPM 서버를 시작 WordPress의 동적 콘텐츠를 처리하기 위해 PHP-FPM이 사용