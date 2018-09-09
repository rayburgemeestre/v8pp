#!/usr/bin/env sh

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=`pwd`/depot_tools:"$PATH"
#fetch --no-history v8
# let's try with history
fetch v8
cd v8
#gclient sync -r 6.9.427.6  # 55da769bafac8b531cd8b388df56161b8b7c6416
# gclient sync -r 7.1.69     # 
#gclient sync -r lkgr/6.9

# newest version I found supported via v8pp CI:
gclient sync -r 6.9.427.13  # https://ci.appveyor.com/project/pmed/v8pp

# old version
#git checkout 5.5.372.7

#GYP_DIR=build
#if [ ! -f "$GYP_DIR"/gyp_v8 ] ; then
#  GYP_DIR=gypfiles
#fi
# Google got rid of this gyp stuff: https://chromium-review.googlesource.com/c/v8/v8/+/897566
# Looks like we have to use GN now: https://github.com/v8/v8/wiki/Building-with-GN

# OLD
#GYP_GENERATORS=make "$GYP_DIR"/gyp_v8 --generator-output=out --depth=. -I"$GYP_DIR"/standalone.gypi -I../v8_options.gypi "$GYP_DIR"/all.gyp
#make v8 v8_libplatform -C out BUILDTYPE=Release -j8 builddir=$(pwd)/out/Release

# NEW
# ./build/install-build-deps.sh
./tools/dev/gm.py x64.release

# workaround, see notes.txt
echo "v8_enable_embedded_builtins = false" >> cat out/x64.release/args.gn
./tools/dev/gm.py x64.release

#mkdir -p lib
#cp out/Release/lib.target/*.so lib
#cp out/Release/lib* lib
#cp out/x64.release/obj/*.a lib
#cp out/x64.release/obj/*.so lib
#cp out/x64.release/obj/libv8* lib
cd ..
#./v8/out/x64.release/obj/libv8_libbase.a
