#!/bin/bash

NDK="/usr/local/android/android-ndk-r14b/"
# PLATFORM=$NDK/platforms/android-18/arch-arm/
PLATFORM=$NDK/platforms/android-24/arch-arm/
# PLATFORM=/opt/workspace/abies-n-4.9/prebuilts/ndk/current/platforms/android-24/arch-arm

# NDK="/usr/local/android/android-ndk-r14b/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64"
TOOLCHAIN=$NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64
# TOOLCHAIN=/opt/workspace/abies-n-4.9/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9
# TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/aarch64-linux-android
PREFIX=./android/arm

function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-shared \
  --enable-pic \
  --host=arm-linux \
  --cross-prefix=$TOOLCHAIN/bin/arm-linux-androideabi- \
  --sysroot=$PLATFORM \
  --extra-cflags="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all"
  --extra-ldflags="-Wl,-z,relro -Wl,-z,now -pie -fPIE"

  make clean
  make
  make install
}

build_one

echo Android ARM builds finished

# CFLAGS='-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all'
# LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie'
