set(vapoursynth_pkgconfig_libs "-lVapourSynth -Wl,-delayload=VapourSynth.dll")
set(vapoursynth_script_pkgconfig_libs "-lVSScript -Wl,-delayload=VSScript.dll")
if(CLANG_PACKAGES_LTO)
    set(cargo_lto_rustflags "CARGO_PROFILE_RELEASE_LTO=thin
    RUSTFLAGS='-Ctarget-cpu=${GCC_ARCH} -Cforce-frame-pointers=no -Ccontrol-flow-guard=yes -Clinker-plugin-lto=yes -Cforce-frame-pointers=no -Clto=thin -Cllvm-args=-fp-contract=fast -Zmerge-functions=aliases -Zcombine-cgu=yes -Zfunction-sections=yes -Zno-unique-section-names=yes -Zhas-thread-local=yes -Ztls-model=local-exec -Zthreads=${CPU_COUNT}'")
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(dlltool_image "i386:x86-64")
    set(openssl_target "mingw64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "x86_64-win64-gcc")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(mimalloc_macro "-D_M_X64")
elseif(TARGET_CPU STREQUAL "aarch64")
    set(dlltool_image "arm64")
    set(openssl_target "mingw-arm64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "arm64-win64-gcc")
    set(mpv_gl "-Dgl=disabled -Degl-angle=disabled")
endif()

set(cmake_conf_args
    -GNinja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_TESTING=OFF
)
set(meson_conf_args
    --cross-file=${MESON_CROSS}
    --native-file=${MESON_NATIVE}
)
set(autoshit_confuck_args
    --host=${TARGET_ARCH}
    --prefix=${MINGW_INSTALL_PREFIX}
    --disable-shared
    --enable-static
)
set(autoreshit
    COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
    COMMAND ${EXEC} autoreconf -fi
)
