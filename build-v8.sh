#!/usr/bin/env sh

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=`pwd`/depot_tools:"$PATH"
fetch --no-history v8
cd v8
gclient sync

GYP_DIR=build
if [ ! -f "$GYP_DIR"/gyp_v8 ] ; then
  GYP_DIR=gypfiles
fi

# Google got rid of this gyp stuff: https://chromium-review.googlesource.com/c/v8/v8/+/897566
# Looks like we have to use GN now: https://github.com/v8/v8/wiki/Building-with-GN
#GYP_GENERATORS=make "$GYP_DIR"/gyp_v8 --generator-output=out --depth=. -I"$GYP_DIR"/standalone.gypi -I../v8_options.gypi "$GYP_DIR"/all.gyp
#make v8 v8_libplatform -C out BUILDTYPE=Release -j8 builddir=$(pwd)/out/Release
./tools/dev/gm.py x64.release

mkdir -p lib
#cp out/Release/lib.target/*.so lib
#cp out/Release/lib* lib
cp out/x64.release/obj/*.a lib
cp out/x64.release/obj/*.so lib
cp out/x64.release/obj/libv8* lib
cd ..
#./v8/out/x64.release/obj/libv8_libbase.a
