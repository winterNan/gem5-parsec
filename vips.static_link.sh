#!/bin/bash
#
# Author: Yuan Yao
#         yuan.yao@it.uu.se
#
# Research group UART, Uppsala University
#
# Vips uses libtool for the final link stage
# Even if we set -static, -static-libgcc, -all-static, in the parsec configuration file, vips still got dynamically linked by libtool,
# even though all the dependencies are compiled to static libraries - glib, clib, libxml2 - (*.a) instead of dynamic libraries (*.so).
# This script manually tunes the libtool env to statically link vips using all the *.a libs. 

PARSEC_INSTALL_DIR="/home/runner/work/gem5-parsec/gem5-parsec" # change this according to your need
PARSEC_LIBS_DIR="$PARSEC_INSTALL_DIR/pkgs/libs"

cd $PARSEC_INSTALL_DIR/pkgs/apps/vips/obj/amd64-linux.gcc-hooks/tools/iofuncs

/bin/bash ../../libtool --tag=CC --mode=link gcc -O3 -g -funroll-loops -fprefetch-loop-arrays -static-libgcc -Wl,--hash-style=both,--as-needed -DPARSEC_VERSION=3.0-beta-20150206 -DENABLE_PARSEC_HOOKS -I$PARSEC_LIBS_DIR/hooks/inst/amd64-linux.gcc-hooks/include -DENABLE_M5_CKPTS -static -static-libgcc -L$PARSEC_LIBS_DIR/glib/inst/amd64-linux.gcc-hooks/lib -L$PARSEC_LIBS_DIR/zlib/inst/amd64-linux.gcc-hooks/lib -L/usr/lib64 -L/usr/lib -L$PARSEC_LIBS_DIR/hooks/inst/amd64-linux.gcc-hooks/lib -static -L$PARSEC_LIBS_DIR/glib/inst/amd64-linux.gcc-hooks/lib -L$PARSEC_LIBS_DIR/zlib/inst/amd64-linux.gcc-hooks/lib -L/usr/lib64 -L/usr/lib -L$PARSEC_LIBS_DIR/hooks/inst/amd64-linux.gcc-hooks/lib -static -o vips vips.o -DG_DISABLE_CAST_CHECKS -pthread -I$PARSEC_LIBS_DIR/libxml2/inst/amd64-linux.gcc-hooks/include/libxml2 -I$PARSEC_LIBS_DIR/glib/inst/amd64-linux.gcc-hooks/lib/glib-2.0/include -I$PARSEC_LIBS_DIR/glib/inst/amd64-linux.gcc-hooks/include/glib-2.0 ../../libvips/.libs/libvips.a -L$PARSEC_LIBS_DIR/glib/inst/amd64-linux.gcc-hooks/lib -lgthread-2.0 -pthread -lglib-2.0 -L$PARSEC_LIBS_DIR/glib/inst/amd64-linux.gcc-hooks/lib -L$PARSEC_LIBS_DIR/libxml2/inst/amd64-linux.gcc-hooks/lib -all-static -lgmodule-2.0 -pthread -lxml2 -lgobject-2.0 -lgthread-2.0 -pthread -lglib-2.0 -lm -lhooks

cp vips ../../../../inst/amd64-linux.gcc-hooks/bin/
