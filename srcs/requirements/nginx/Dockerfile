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

# SSL 이란 보안 프로토콜중 하나 https 가 되려면 SSL 프로토콜을 사용해야한다 그 SSL이 어떻게 동작을하냐면 암호화 기능을 해주는게 SSL

# 공개키랑 비밀키
# 공개키를 유저한테 뿌려
# 유저(공개키) 암호화 해서 보내-> 서버(비밀키)확인 

# SSL 키 및 인증서 생성 및 권한 변경
RUN openssl req -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/ssl/private/eunjiko.42.fr.key \
    # 개인키(비밀키)생성
    -x509 -days 365 \
    -out /etc/nginx/ssl/private/eunjiko.42.fr.crt \ 
    # 셀프인증서이자 공개키 365일간 유효 공인은 아님 공인이 아니라 들어갔을때 에러 어쩌구.... 셀프 인증된 애라도 있어야 제대로 동작 아니면 설정 자체가 불가함 
    -subj "/C=KR/ST=Seoul/O=42Seoul/OU=eunjiko/CN=inception/" && \
    chown -R nginx:nginx /etc/nginx/ssl/private && \
    chmod 600 /etc/nginx/ssl/private/eunjiko.42.fr.key /etc/nginx/ssl/private/eunjiko.42.fr.crt
    # 권한주는것?

# EXPOSE 컨테이너가 실행될 때 오픈할 포트 번호를 지정
EXPOSE 443
# 보통 엔진엑스가 443

# COPY 호스트 파일 시스템에서 파일이나 디렉토리를 컨테이너 내부로 복사 일반적으로 호스트에서 빌드 컨텍스트 내에 있는 파일이나 디렉토리를 복사하여 이미지에 포함시키는 데 사용
# Nginx 설정 파일 복사
COPY conf/nginx.conf /etc/nginx/http.d/default.conf

# 정확하지 않음
# 컨테이너에 개별적으로 들어가는것도 알아놓기

# CMD 컨테이너가 시작될 때 실행할 기본 명령어를 지정 CMD 명령어를 사용하여 컨테이너가 실행될 때 실행되는 기본 프로세스를 지정할 수 있음 Dockerfile에서 한 번만 사용될 수 있으며, 여러 개의 CMD가 있을 경우 마지막 CMD가 적용됨 일반적으로 Docker 컨테이너에서 실행될 응용 프로그램이나 서비스를 시작하는 명령어를 지정함
# 부모 프로세스로부터 신호를 처리하도록 dumb-init을 사용하여 nginx를 실행
CMD ["dumb-init", "--" ,"nginx", "-g", "daemon off;"]
# dumbinit 추가
# ngin 
# daemon off
# -- 이렇게 해야 그 뒤에 애들이 하위 프로세스로 동작하게 한다
#pid1을 dumbinit 컨테이너를 계속 살려둬야해서 / nginx를 실행한다  /  -g :   / daemon off :



