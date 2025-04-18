#!/bin/bash
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=OFF \
-DCLANG_PACKAGES_LTO=ON \
-DCLANG_PACKAGES_PGO=ON \
-DLLVM_ENABLE_PGO=CSGEN \
-DLLVM_PROFDATA_FILE="/build/llvm.profdata" \
-DCLANG_FLAGS="-mprefer-vector-width=512" \
-DTOOLCHAIN_FLAGS="-mprefer-vector-width=256" \
-DCUSTOM_LIBCXX=ON \
-G Ninja \
-B /build
./utils/download.sh
