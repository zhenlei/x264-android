#!/bin/bash

NDK="/usr/local/android/android-ndk-r14b/"
# PLATFORM=$NDK/platforms/android-18/arch-arm/
# PLATFORM=$NDK/platforms/android-24/arch-arm64/
PLATFORM=/opt/workspace/abies-n-4.9/prebuilts/ndk/current/platforms/android-24/arch-arm64

# TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64
TOOLCHAIN=/opt/workspace/abies-n-4.9/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9
# TOOLCHAIN=$NDK/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/aarch64-linux-android
PREFIX=./android/arm64

function build_one
{
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-shared \
  --enable-pic \
  --host=aarch64-linux \
  --cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
  --sysroot=$PLATFORM \
  --extra-cflags="-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all"
  --extra-ldflags="-Wl,-z,relro -Wl,-z,now -pie -fPIE"

  make clean
  make
  make install
}

build_one

echo Android ARM64 builds finished

# CFLAGS='-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -fno-strict-overflow -fstack-protector-all'
# LDFLAGS='-Wl,-z,relro -Wl,-z,now -pie'
