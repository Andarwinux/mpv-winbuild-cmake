#!/bin/sh
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DMARCH=native \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=OFF \
-DLLVM_ENABLE_UNSAFE_X86_AVX512_VFABI=ON \
-DENABLE_CCACHE=OFF \
-DCLANG_PACKAGES_PGO=GEN \
-DCLANG_FLAGS="-mprefer-vector-width=512 -mno-gather" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=256 -mno-gather -Wl,-mllvm,-x86-use-fsrm-for-memcpy" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-G Ninja \
-B /build
./utils/download.sh
