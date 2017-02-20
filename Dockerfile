# https://www.vultr.com/docs/setup-nginx-rtmp-on-ubuntu-14-04

FROM ubuntu:latest

MAINTAINER Leon Berenschot <leipeleon@gmail.com>

# Update and install ubuntu packages
RUN apt-get -y update && apt-get -y install \
  build-essential \
  libpcre3 \
  libpcre3-dev \
  libssl-dev \
  wget \
  ffmpeg \
  git \
  && rm -rf /var/lib/apt/lists/*

# RTMP module
RUN wget https://github.com/arut/nginx-rtmp-module/archive/master.tar.gz && \
    tar -zxvf master.tar.gz && \
    rm master.tar.gz

ENV NGINX_VERSION 1.11.10
# NGINX
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
    tar -zxvf nginx-${NGINX_VERSION}.tar.gz && \
    cd nginx-${NGINX_VERSION} && \
    ./configure --with-http_ssl_module --with-http_stub_status_module --add-module=../nginx-rtmp-module-master && \
    make && make install

# Install config and start
# RUN wget https://github.com/LeipeLeon/docker-nginx-rtmp/archive/master.tar.gz && \
#     tar -zxvf master.tar.gz && \
#     rm /usr/local/nginx/conf/nginx.conf && \
RUN mkdir -vp /HLS/live && \
    mkdir -vp /video_recordings && \
    chmod -R 777 /video_recordings

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
COPY html /usr/local/nginx/html

# # forward request and error logs to docker log collector
# RUN mkdir -p /var/log/nginx/ \
#     && ln -sf /dev/stdout /var/log/nginx/access.log \
#     && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443 1935

CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
