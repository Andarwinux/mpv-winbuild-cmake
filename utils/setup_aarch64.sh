#!/bin/sh
cmake -DTARGET_ARCH=aarch64-w64-mingw32 \
-DMARCH=cortex-x3 \
-DMARCH_NAME='' \
-DSINGLE_SOURCE_LOCATION="/build/src_packages/" \
-DCMAKE_INSTALL_PREFIX="/build/install" \
-DMINGW_INSTALL_PREFIX="/build_aarch64/install/aarch64-w64-mingw32" \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DCCACHE_MAXSIZE=8G \
-DCLANG_PACKAGES_PGO=OFF \
-DCLANG_PACKAGES_PROFDATA_FILE="/build/pgo.profdata" \
-DCUSTOM_LIBCXX=ON \
-DCUSTOM_COMPILER_RT=ON \
-G Ninja \
-B /build_aarch64
