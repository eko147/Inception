FROM alpine:3.18

RUN apk update && \
    apk upgrade && \
    apk add --no-cache dumb-init

RUN apk add --no-cache nginx openssl && \
    mkdir -p /etc/nginx/ssl/private && \
    mkdir -p /var/www/html

RUN openssl req -newkey rsa:2048 -nodes \
    -keyout /etc/nginx/ssl/private/eunjiko.42.fr.key \
    -x509 -days 365 \
    -out /etc/nginx/ssl/private/eunjiko.42.fr.crt \ 
    -subj "/C=KR/ST=Seoul/O=42Seoul/OU=eunjiko/CN=inception/" && \
    chown -R nginx:nginx /etc/nginx/ssl/private && \
    chmod 600 /etc/nginx/ssl/private/eunjiko.42.fr.key /etc/nginx/ssl/private/eunjiko.42.fr.crt

EXPOSE 443

COPY conf/nginx.conf /etc/nginx/http.d/default.conf

CMD ["dumb-init", "--" ,"nginx", "-g", "daemon off;"]