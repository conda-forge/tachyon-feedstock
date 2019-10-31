#!/bin/bash

cd unix

if [ -z "$RANLIB" ]; then
    export RANLIB=ranlib
fi
if [ -z "$STRIP" ]; then
    export STRIP=strip
fi
if [ -z "$AR" ]; then
    export AR=ar
fi

if [[ "${target_platform}" == linux* ]]; then
    make all \
    "ARCH = linux-64-thr" \
    "CC = $CC" \
    "CFLAGS = -Wall -O3 -fomit-frame-pointer -ffast-math -DLinux  -DTHR -DUSEATOMICBARRIERS -D_REENTRANT -DUSEPNG -DUSEJPEG $CPPFLAGS $CFLAGS" \
    "AR = $AR" \
    "ARFLAGS = r" \
    "STRIP = $STRIP" \
    "RANLIB = $RANLIB" \
    "LIBS = -L. -ltachyon $LDFLAGS -lpng -lz -ljpeg -lm -lpthread";
else
    make all \
    "ARCH = macosx-x86-thr" \
    "CC = $CC" \
    "CFLAGS = -Os -ffast-math -DBsd -DTHR -DUSEATOMICBARRIERS -DUSEPNG -DUSEJPEG $CPPFLAGS $CFLAGS" \
    "AR = $AR" \
    "ARFLAGS = r" \
    "STRIP = $STRIP" \
    "RANLIB = $RANLIB" \
    "LIBS = -L. -ltachyon -lpng -lz -ljpeg -lpthread $LDFLAGS";
fi

cd ..
cp compile/*/tachyon "$PREFIX/bin"
