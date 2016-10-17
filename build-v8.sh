#!/usr/bin/env sh

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=`pwd`/depot_tools:"$PATH"
fetch --no-history v8
cd v8
gclient sync

git checkout 55da769bafac8b531cd8b388df56161b8b7c6416 # something got broken after this commit and 17th of October 2016
# the libplatform.a was not generated anymore (only the .so), the new build system (gn) does build it, but then other 
# stuff is missing and linking fails.. so for now I will stick with this hash for my project..

GYP_DIR=build
if [ ! -f "$GYP_DIR"/gyp_v8 ] ; then
  GYP_DIR=gypfiles
fi

GYP_GENERATORS=make "$GYP_DIR"/gyp_v8 --generator-output=out --depth=. -I"$GYP_DIR"/standalone.gypi -I../v8_options.gypi "$GYP_DIR"/all.gyp
make v8 v8_libplatform -C out BUILDTYPE=Release -j8 builddir=$(pwd)/out/Release
mkdir -p lib
cp out/Release/lib.target/*.so lib
cp out/Release/lib* lib
cd ..

