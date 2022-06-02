#!/usr/bin/env bash
#
# --------------------------------------------------------------------
# (C) 2022 Retro Games Ltd
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 1, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# --------------------------------------------------------------------

ARCH=arm-linux-gnueabihf

BASE=${PWD}
export BASE

PATH=/usr/${ARCH}/bin:${PATH}
STAMP=.stamp.built

BUILDCONF="\
--host=${ARCH} \
--build=x86_64-pc-linux-gnu \
--prefix=/usr/${ARCH} \
--exec-prefix=/usr/${ARCH} \
--sysconfdir=/etc \
--localstatedir=/var \
--program-prefix"

get_git()
{
    HOST=$1
    REPO=$2
    BRANCH=$3

    if [ ! -d ${REPO} ]
    then
        A="${HOST}/${REPO}.git --single-branch"
        if [ ! -z "${BRANCH}" ]; then A="${A} --branch ${BRANCH}"; fi
        git clone ${A}
    fi
}
get_tgz()
{
    LOCATION=$1
    SRC=$2

    if [ ! -d ${SRC} ]
    then
        wget ${LOCATION}/${SRC}.tar.gz
        tar -xf ${SRC}.tar.gz
        rm ${SRC}.tar.gz
    fi
}

# Get sources
#
MALIFB_REPO=malifb-rb
SDL2_MALIFB_REPO=SDL-mirror
AMIBERRY_REPO=redquark-amiberry-rb
SDL2_IMAGE_SRC=SDL2_image-2.0.5
SDL2_TTF_SRC=SDL2_ttf-2.0.15

get_git "https://github.com/retro-games-ltd" ${MALIFB_REPO}
get_git "https://github.com/retro-games-ltd" ${SDL2_MALIFB_REPO} "feature/malifb"
get_git "https://github.com/retro-games-ltd" ${AMIBERRY_REPO}    "redquark-v3_3"
get_tgz "https://www.libsdl.org/projects/SDL_image/release" ${SDL2_IMAGE_SRC}
get_tgz "https://www.libsdl.org/projects/SDL_ttf/release" ${SDL2_TTF_SRC}

# Build
#
cd ${BASE}/${MALIFB_REPO}
if [ ! -f /usr/${ARCH}/include/malifb.h ]
then
  cp -p libmalifb.so /usr/${ARCH}/lib
  cp -p malifb.h     /usr/${ARCH}/include
fi

cd ${BASE}/${SDL2_MALIFB_REPO}
if [ ! -f config.log ]
then
  ./configure ${BUILDCONF} --disable-gtk-doc --enable-static --enable-shared --disable-alsa-shared --disable-oss --disable-diskaudio --disable-video-vulkan --disable-video-opengles1 --disable-ime --enable-video-mali --disable-rpath --disable-arts --disable-esd --disable-dbus --disable-pulseaudio --disable-video-wayland --enable-static --enable-libudev --disable-sse --disable-3dnow --disable-video-directfb --disable-video-rpi --disable-video-x11 --without-x --disable-video-opengl --enable-video-opengles --disable-input-tslib --enable-alsa --disable-video-kmsdrm
    
  make -j14
  make install
fi

cd ${BASE}/${SDL2_IMAGE_SRC}
if [ ! -f config.log ]
then
  ./configure ${BUILDCONF} --disable-gtk-doc --enable-static --enable-shared --disable-alsa-shared --disable-oss --disable-diskaudio --disable-video-vulkan --disable-video-opengles1 --disable-ime --enable-video-mali --disable-rpath --disable-arts --disable-esd --disable-dbus --disable-pulseaudio --disable-video-wayland --enable-static --enable-libudev --disable-sse --disable-3dnow --disable-video-directfb --disable-video-rpi --disable-video-x11 --without-x --disable-video-opengl --enable-video-opengles --disable-input-tslib --enable-alsa --disable-video-kmsdrm
    
  make -j14
  make install
fi

cd ${BASE}/${SDL2_TTF_SRC}
if [ ! -f config.log ]
then
  ./configure ${BUILDCONF} --disable-gtk-doc --enable-static --enable-shared --disable-alsa-shared --disable-oss --disable-diskaudio --disable-video-vulkan --disable-video-opengles1 --disable-ime --enable-video-mali --disable-rpath --disable-arts --disable-esd --disable-dbus --disable-pulseaudio --disable-video-wayland --enable-static --enable-libudev --disable-sse --disable-3dnow --disable-video-directfb --disable-video-rpi --disable-video-x11 --without-x --disable-video-opengl --enable-video-opengles --disable-input-tslib --enable-alsa --disable-video-kmsdrm
    
  make -j14
  make install
fi

cd ${BASE}/${AMIBERRY_REPO}

AS=${ARCH}-as \
CC=${ARCH}-gcc \
CXX=${ARCH}-g++-8 \
STRIP=${ARCH}-strip \
SDL_CONFIG="/usr/${ARCH}/bin/sdl2-config" \
MALIFB_CFLAGS="-I/usr/${ARCH}/include" \
MALIFB_LDFLAGS="-L/usr/${ARCH}/lib -lmalifb -lEGL -lGLESv2" \
PLATFORM="redquark-sun50i" \
make -j14
rv=$?

if [ $rv -eq 0 ] && ( [ ! -f ${STAMP} ] || [[ amiberry -nt ${STAMP} ]] )
then
  echo patch
  patchelf --replace-needed libEGL.so.1 libEGL.so amiberry
  patchelf --replace-needed libGLESv2.so.2 libGLESv2.so amiberry
  touch -r amiberry ${STAMP}
fi

echo Done
