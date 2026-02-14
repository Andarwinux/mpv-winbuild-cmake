#!/bin/bash
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DMARCH=native \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Full \
-DLLVM_ENABLE_UNSAFE_X86_AVX512_VFABI=ON \
-DENABLE_CCACHE=OFF \
-DCLANG_PACKAGES_PGO=OFF \
-DLLVM_ENABLE_PGO=USE \
-DLLVM_PROFDATA_FILE="/build/llvm.profdata" \
-DCLANG_FLAGS="" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=256 -mno-gather -Wl,-mllvm,-x86-use-fsrm-for-memcpy,-mllvm,-lv-strided-pointer-ivs" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-G Ninja \
-B /build
./utils/download.sh
