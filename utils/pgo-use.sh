#!/bin/sh
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DMARCH=native \
-DMTUNE=native \
-DMARCH_NAME=-native \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DCCACHE_MAXSIZE=8G \
-DCLANG_PACKAGES_PGO=USE \
-DCLANG_PACKAGES_PROFDATA_FILE="/build/pgo.profdata" \
-DCLANG_FLAGS="-mprefer-vector-width=512" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=256 -mno-gather -Wl,-mllvm,-x86-use-fsrm-for-memcpy" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-DQT_DISABLE_CCACHE=ON \
-G Ninja \
-B /build
./utils/download.sh
