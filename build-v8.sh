#!/usr/bin/env sh

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=`pwd`/depot_tools:"$PATH"
fetch --no-history v8
cd v8
gclient sync
GYP_GENERATORS=make gypfiles/gyp_v8 --generator-output=out --depth=. -Igypfiles/standalone.gypi -I../v8_options.gypi gypfiles/all.gyp
make v8 v8_libplatform -C out BUILDTYPE=Release -j8 builddir=$(pwd)/out/Release
mkdir -p lib
cp out/Release/lib.target/*.so lib
cp out/Release/lib* lib
cd ..

