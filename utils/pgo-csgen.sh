#!/bin/sh
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DMARCH=native \
-DMTUNE=native \
-DMARCH_NAME=-native \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DLLVM_ENABLE_UNSAFE_X86_AVX512_VFABI=ON \
-DENABLE_CCACHE=ON \
-DCCACHE_MAXSIZE=8G \
-DCLANG_PACKAGES_PGO=CSGEN \
-DCLANG_PACKAGES_PROFDATA_FILE="/build/pgo.profdata" \
-DCLANG_FLAGS="" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=512 -mno-gather -Wl,-mllvm,-x86-use-fsrm-for-memcpy" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-DQT_DISABLE_CCACHE=ON \
-G Ninja \
-B /build
./utils/download.sh
