# FROM Docker 이미지의 베이스로 사용할 이미지를 지정 보통은 운영 체제나 프레임워크의 이미지를 기반으로 하며, 기본적인 환경을 설정
FROM alpine:3.18

#Package Install
# RUN 컨테이너 내에서 실행할 명령어
#&& 연산자는 첫 번째 명령어가 성공적으로 실행된 후에만 다음 명령어를 실행
    # dumb init 부모 프로세스로부터 신호를 처리

    #. --no-cache 옵션은 패키지 설치 후에 apk 캐시를 지우는 것을 막습니다. 이는 Docker 이미지의 크기를 줄이고 캐시로 인한 잠재적인 문제를 방지하는 데 도움이 됩니다. 

# 패키지 업데이트 및 dumb-init 설치
RUN apk update && \
    apk upgrade && \
    apk add --no-cache dumb-init

# Nginx와 OpenSSL 설치
RUN apk add --no-cache nginx openssl && \
    mkdir -p /etc/nginx/ssl/private && \
    mkdir -p /var/www/html


# SSL 키 및 인증서 생성 및 권한 변경
RUN openssl req -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/ssl/private/seokchoi.42.fr.key \
    -x509 -days 365 -out /etc/nginx/ssl/private/seokchoi.42.fr.crt \
    -subj "/C=KR/ST=Seoul/O=42Seoul/OU=seokchoi/CN=inception/" && \
    chown -R nginx:nginx /etc/nginx/ssl/private && \
    chmod 600 /etc/nginx/ssl/private/seokchoi.42.fr.key /etc/nginx/ssl/private/seokchoi.42.fr.crt

# EXPOSE 컨테이너가 실행될 때 오픈할 포트 번호를 지정
EXPOSE 443

# COPY 호스트 파일 시스템에서 파일이나 디렉토리를 컨테이너 내부로 복사 일반적으로 호스트에서 빌드 컨텍스트 내에 있는 파일이나 디렉토리를 복사하여 이미지에 포함시키는 데 사용
# Nginx 설정 파일 복사
COPY nginx.conf /etc/nginx/nginx.conf
# 정확하지 않음

# CMD 컨테이너가 시작될 때 실행할 기본 명령어를 지정 CMD 명령어를 사용하여 컨테이너가 실행될 때 실행되는 기본 프로세스를 지정할 수 있음 Dockerfile에서 한 번만 사용될 수 있으며, 여러 개의 CMD가 있을 경우 마지막 CMD가 적용됨 일반적으로 Docker 컨테이너에서 실행될 응용 프로그램이나 서비스를 시작하는 명령어를 지정함
# 부모 프로세스로부터 신호를 처리하도록 dumb-init을 사용하여 nginx를 실행
CMD ["dumb-init", "nginx", "-g", "daemon off;"]
# dumbinit 추가

# CMD ['bash'];

# FROM alpine:3.18
# CMD ["/bin/sh"]


