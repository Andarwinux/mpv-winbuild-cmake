#!/bin/bash
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DLLVM_CCACHE_BUILD=OFF \
-DCLANG_PACKAGES_LTO=ON \
-DCLANG_PACKAGES_PGO=USE \
-DCLANG_PACKAGES_PROFDATA_FILE="/build/pgo.profdata" \
-DLLVM_ENABLE_PGO=GEN \
-DCLANG_FLAGS="-mprefer-vector-width=512 -mno-gather" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=256 -mno-gather" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-DHOST_HARDEN=OFF \
-DCREL_AVAILABLE=OFF \
-DCET_AVAILABLE=OFF \
-G Ninja \
-B /build \
-Wno-dev
./utils/download.sh
