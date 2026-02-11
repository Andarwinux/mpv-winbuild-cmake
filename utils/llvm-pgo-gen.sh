#!/bin/bash
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DMARCH=native \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DLLVM_ENABLE_UNSAFE_X86_AVX512_VFABI=ON \
-DENABLE_CCACHE=ON \
-DCLANG_PACKAGES_PGO=USE \
-DCLANG_PACKAGES_PROFDATA_FILE="/build/pgo.profdata" \
-DLLVM_ENABLE_PGO=GEN \
-DCLANG_FLAGS="" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=256 -mno-gather -Wl,-mllvm,-x86-use-fsrm-for-memcpy,-mllvm,-lv-strided-pointer-ivs" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-G Ninja \
-B /build
./utils/download.sh
