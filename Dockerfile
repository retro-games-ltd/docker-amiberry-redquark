# THEA500 Amiberry Redquark build
# (c) 2022 Retro Games Ltd
#
FROM debian:buster-slim
MAINTAINER RetroGame Support <support@retrogames.biz>

RUN dpkg --add-architecture armhf
RUN apt-get update
RUN apt-get install -y make gcc autoconf nasm yasm git wget gcc-arm-linux-gnueabihf binutils-arm-linux-gnueabihf g++-8-arm-linux-gnueabihf patchelf libflac-dev:armhf libmpg123-dev:armhf libpng-dev:armhf libmpeg2-4-dev:armhf libxml2-dev:armhf zlib1g-dev:armhf libfreetype6-dev:armhf libharfbuzz-dev:armhf libegl1-mesa-dev:armhf libgles2-mesa-dev:armhf

COPY ./freetype-config /usr/arm-linux-gnueabihf/bin/

WORKDIR /build

COPY ./bootstrap.sh /build
RUN chmod +x /build/bootstrap.sh
RUN ./bootstrap.sh

CMD [ "bash" ]
