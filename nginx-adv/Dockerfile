##############################
# Installation settings
##############################

ARG ALPINE_VERSION=latest
ARG NGINX_VERSION=1.19.2

FROM alpine:${ALPINE_VERSION}

LABEL MAINTAINER="Kim Hsiao <white.shopping@gmail.com>"
LABEL ALPINE_VERSION=${ALPINE_VERSION}
LABEL NGINX_VERSION=${NGINX_VERSION}

##############################
# Base setting
##############################
ARG NPROC=1
ARG NGINX_VERSION=1.19.2
ARG NGINX_DEVEL_KIT_VERSION=0.3.1
ARG NGINX_RTMP_MODULE_VERSION=1.2.1
ARG NGINX_LUA_MODULE_VERSION=0.10.16
ARG LUA_JIT_VERSION=2.0.5
ARG NGINX_LUA_RESTY_VERSION=0.1.16
ARG NGINX_STREAM_LUA_MODULE_VERSION=0.0.8
ARG NGINX_LUA_RESTY_LRUCACHE_VERSION=0.10
ARG FFMPEG_VERSION=4.3.1
ARG LUAROCKS_VERSION=3.3.1
ARG OPENRESTY_VERSION=1.17.8.2
ARG HEADERS_MORE_MODULE_VERSION=0.33

ENV NGINX_DEVEL_KIT=ngx_devel_kit-${NGINX_DEVEL_KIT_VERSION}
ENV NGINX_RTMP_MODULE=nginx-rtmp-module-${NGINX_RTMP_MODULE_VERSION}
ENV NGINX_LUA_MODULE=lua-nginx-module-${NGINX_LUA_MODULE_VERSION}
ENV NGINX_LUA_RESTY_CORE=lua-resty-core-${NGINX_LUA_RESTY_VERSION}
ENV NGINX_STREAM_LUA_MODULE=stream-lua-nginx-module-${NGINX_STREAM_LUA_MODULE_VERSION}
ENV NGINX_LUA_RESTY_LRUCACHE=lua-resty-lrucache-${NGINX_LUA_RESTY_LRUCACHE_VERSION}
ENV NGINX_HEADER_MORE_MODULE=headers-more-nginx-module-${HEADERS_MORE_MODULE_VERSION}
ENV LUAROCKS=luarocks-${LUAROCKS_VERSION}
ENV OPENRESTY=openresty-${OPENRESTY_VERSION}

ENV LUAJIT_LIB=/usr/local/lib
ENV LUAJIT_INC=/usr/local/include/luajit-2.0

##############################
# Set Timezone
##############################
USER root

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime && \
  echo ${TZ} > /etc/timezone

##############################
# Add user
##############################
RUN addgroup -S www-data && \
  adduser -S www-data -G www-data

##############################
# Install dependencies
##############################
# Update certificates
RUN apk update && \
  apk add openssl ca-certificates && \
  update-ca-certificates

# Common dependencies
RUN apk update && \
  apk add --virtual .common-dependencies \
    bash \
    nano \
    lua \
    libgcc \
    openssl \
    coreutils \
    pcre

# Common build tools
RUN apk update && \
  apk add --virtual .build-dependencies \
    git \
    perl \
    patch \
    unzip \
    binutils \
    build-base \
    make \
    pkgconf \
    pkgconfig \
    openssl-dev \
    nasm \
    yasm \
    yasm-dev \
    musl-dev \
    libc-dev \
    pcre-dev \
    zlib-dev \
    lua-dev \
    linux-headers

##############################
# Build packages
##############################
# Build luarocks
WORKDIR /tmp

RUN wget -c https://github.com/luarocks/luarocks/archive/v${LUAROCKS_VERSION}.tar.gz -O ${LUAROCKS}.tar.gz && \
  tar zxvf ${LUAROCKS}.tar.gz && \
  rm ${LUAROCKS}.tar.gz && \
  cd ${LUAROCKS} && \
  ./configure && \
  make build -j${NPROC} && \
  make install && \
  make clean

# Build LuaJIT
WORKDIR /tmp

RUN wget -c http://luajit.org/download/LuaJIT-${LUA_JIT_VERSION}.tar.gz && \
  tar zxvf LuaJIT-${LUA_JIT_VERSION}.tar.gz && \
  rm LuaJIT-${LUA_JIT_VERSION}.tar.gz && \
  cd LuaJIT-${LUA_JIT_VERSION} && \
  make -j${NPROC} && \
  make install && \
  make clean

# Build OpenResty
WORKDIR /tmp

RUN wget -c https://openresty.org/download/openresty-${OPENRESTY_VERSION}.tar.gz -O ${OPENRESTY}.tar.gz && \
  tar zxvf ${OPENRESTY}.tar.gz && \
  rm ${OPENRESTY}.tar.gz && \
  cd ${OPENRESTY} && \
  ./configure -j${NPROC} && \
  make -j${NPROC} && \
  make install && \
  make clean

# Build lua-resty-core
WORKDIR /tmp

RUN wget -c https://github.com/openresty/lua-resty-core/archive/v${NGINX_LUA_RESTY_VERSION}.tar.gz -O ${NGINX_LUA_RESTY_CORE}.tar.gz && \
  tar zxvf ${NGINX_LUA_RESTY_CORE}.tar.gz && \
  rm ${NGINX_LUA_RESTY_CORE}.tar.gz && \
  cd ${NGINX_LUA_RESTY_CORE} && \
  make -j${NPROC} && \
  make install

# Build lua-resty-lrucache
WORKDIR /tmp

RUN wget -c https://github.com/openresty/lua-resty-lrucache/archive/v${NGINX_LUA_RESTY_LRUCACHE_VERSION}.tar.gz -O ${NGINX_LUA_RESTY_LRUCACHE}.tar.gz && \
  tar zxvf ${NGINX_LUA_RESTY_LRUCACHE}.tar.gz && \
  rm ${NGINX_LUA_RESTY_LRUCACHE}.tar.gz && \
  cd ${NGINX_LUA_RESTY_LRUCACHE} && \
  make -j${NPROC} && \
  make install

# Get ngx_devel_kit
WORKDIR /tmp

RUN wget -c https://github.com/simpl/ngx_devel_kit/archive/v${NGINX_DEVEL_KIT_VERSION}.tar.gz -O ${NGINX_DEVEL_KIT}.tar.gz && \
  tar zxvf ${NGINX_DEVEL_KIT}.tar.gz && \
  rm ${NGINX_DEVEL_KIT}.tar.gz

# Get nginx-rtmp module
WORKDIR /tmp

COPY ./patch/ngx_rtmp_eval.patch /tmp/ngx_rtmp_eval.patch
RUN if [ ${NGINX_RTMP_MODULE_VERSION} = master ]; then \
  wget -c https://github.com/arut/nginx-rtmp-module/archive/${NGINX_RTMP_MODULE_VERSION}.tar.gz -O ${NGINX_RTMP_MODULE}.tar.gz \
  ;else \
  wget -c https://github.com/arut/nginx-rtmp-module/archive/v${NGINX_RTMP_MODULE_VERSION}.tar.gz -O ${NGINX_RTMP_MODULE}.tar.gz \
  ;fi && \
  tar zxvf ${NGINX_RTMP_MODULE}.tar.gz && \
  cd ${NGINX_RTMP_MODULE} && \
  # patch for rtmp issue, reference to https://github.com/arut/nginx-rtmp-module/issues/1358
  patch -p0 -f < /tmp/ngx_rtmp_eval.patch && \
  rm /tmp/${NGINX_RTMP_MODULE}.tar.gz

# Get strem lua module
WORKDIR /tmp

RUN wget -c https://github.com/openresty/stream-lua-nginx-module/archive/v${NGINX_STREAM_LUA_MODULE_VERSION}.tar.gz -O ${NGINX_STREAM_LUA_MODULE}.tar.gz && \
  tar zxvf ${NGINX_STREAM_LUA_MODULE}.tar.gz && \
  rm ${NGINX_STREAM_LUA_MODULE}.tar.gz

# Get lua-nginx-module
WORKDIR /tmp

RUN wget -c https://github.com/openresty/lua-nginx-module/archive/v${NGINX_LUA_MODULE_VERSION}.tar.gz -O ${NGINX_LUA_MODULE}.tar.gz && \
  tar zxvf ${NGINX_LUA_MODULE}.tar.gz && \
  rm ${NGINX_LUA_MODULE}.tar.gz

# Get headers-more-module
WORKDIR /tmp

RUN wget -c https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_MORE_MODULE_VERSION}.tar.gz -O ${NGINX_HEADER_MORE_MODULE}.tar.gz && \
  tar zxvf ${NGINX_HEADER_MORE_MODULE}.tar.gz && \
  rm ${NGINX_HEADER_MORE_MODULE}.tar.gz

##############################
# Build nginx
##############################
WORKDIR /tmp

# Get nginx source
RUN wget -c http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz && \
  tar zxvf nginx-${NGINX_VERSION}.tar.gz && \
  rm nginx-${NGINX_VERSION}.tar.gz

# Build nginx
WORKDIR /tmp/nginx-${NGINX_VERSION}

RUN ./configure \
  --prefix=/etc/nginx \
  --sbin-path=/usr/sbin/nginx \
  --modules-path=/usr/lib/nginx/modules \
  --conf-path=/etc/nginx/nginx.conf \
  --error-log-path=/var/log/nginx/error.log \
  --http-log-path=/var/log/nginx/access.log \
  --pid-path=/var/run/nginx.pid \
  --lock-path=/var/run/nginx.lock \
  --http-client-body-temp-path=/var/cache/nginx/client_temp \
  --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
  --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
  --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
  --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
  --with-perl_modules_path=/usr/lib/perl5/vendor_perl \
  --user=nginx \
  --group=nginx \
  --with-compat \
  --with-file-aio \
  --with-threads \
  --with-http_addition_module \
  --with-http_auth_request_module \
  --with-http_dav_module \
  --with-http_flv_module \
  --with-http_gunzip_module \
  --with-http_gzip_static_module \
  --with-http_mp4_module \
  --with-http_random_index_module \
  --with-http_realip_module \
  --with-http_secure_link_module \
  --with-http_slice_module \
  --with-http_ssl_module \
  --with-http_stub_status_module \
  --with-http_sub_module \
  --with-http_v2_module \
  --with-mail \
  --with-mail_ssl_module \
  --with-stream \
  --with-stream_realip_module \
  --with-stream_ssl_module \
  --with-stream_ssl_preread_module \
  --add-module=/tmp/${NGINX_DEVEL_KIT} \
  --add-module=/tmp/${NGINX_LUA_MODULE} \
  --add-module=/tmp/${NGINX_RTMP_MODULE} \
  --add-module=/tmp/${NGINX_HEADER_MORE_MODULE} \
  --add-module=/tmp/${NGINX_STREAM_LUA_MODULE} \
  --with-cc-opt="-Os -fomit-frame-pointer" \
  --with-ld-opt="-Wl,-rpath,${LUAJIT_LIB}"

RUN make -j${NPROC} && \
  make install

##############################
# Build ffmpeg
##############################
WORKDIR /tmp

# Install ffmpeg dependence
RUN apk update && \
  apk add --update --virtual .ffmpeg-dependencies \
    gnutls-dev \
    libogg-dev \
    libvpx-dev \
    libvorbis-dev \
    freetype-dev \
    libass-dev \
    libwebp-dev \
    rtmpdump-dev \
    libtheora-dev \
    lame-dev \
    xvidcore-dev \
    imlib2-dev \
    x264-dev \
    bzip2-dev \
    perl-dev \
    libvpx-dev \
    sdl2-dev \
    libxfixes-dev \
    libva-dev \
    alsa-lib-dev \
    v4l-utils-dev \
    opus-dev \
    x265-dev

# Add additional fdk-aac
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
  apk add --update fdk-aac-dev

# Get ffmpeg source
RUN wget -c http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz && \
  tar zxvf ffmpeg-${FFMPEG_VERSION}.tar.gz && \
  rm ffmpeg-${FFMPEG_VERSION}.tar.gz

# Build ffmpeg
WORKDIR /tmp/ffmpeg-${FFMPEG_VERSION}

RUN ./configure \
  --enable-version3 \
  --enable-gpl \
  --enable-nonfree \
  --enable-small \
  --enable-libmp3lame \
  --enable-libx264 \
  --enable-libx265 \
  --enable-libvpx \
  --enable-libtheora \
  --enable-libvorbis \
  --enable-libopus \
  --enable-libfdk-aac \
  --enable-libass \
  --enable-libwebp \
  --enable-librtmp \
  --enable-postproc \
  --enable-avresample \
  --enable-libfreetype \
  --enable-openssl \
  --enable-avfilter \
  --enable-libxvid \
  --enable-libv4l2 \
  --enable-pic \
  --enable-shared \
  --enable-vaapi \
  --enable-pthreads \
  --enable-shared \
  --disable-stripping \
  --disable-static \
  --disable-debug

RUN make -j${NPROC} && \
  make install && \
  make distclean

##############################
# Add php support
##############################
ARG PHP_UPSTREAM_CONTAINER=workspace
ARG PHP_UPSTREAM_PORT=9000

# Set upstream conf and remove the default conf
RUN mkdir -p /etc/nginx/conf.d && \
  echo "upstream php-upstream { server ${PHP_UPSTREAM_CONTAINER}:${PHP_UPSTREAM_PORT}; }" > /etc/nginx/conf.d/upstream.conf

##############################
# Cleanup
##############################
# Remove unnecessary dependencies
RUN apk del .ffmpeg-dependencies \
  .build-dependencies

# Cleanup tmp folder
RUN rm -rf /tmp/*

##############################
# Finally
##############################
WORKDIR /

# RTMP port
EXPOSE 1935

# HTTP ports
EXPOSE 80 443 2018

CMD ["/usr/sbin/nginx"]
