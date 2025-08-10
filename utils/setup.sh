#!/bin/sh
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DMARCH=native \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DCCACHE_MAXSIZE=2G \
-DCLANG_FLAGS="-mprefer-vector-width=512" \
-G Ninja \
-B /build
