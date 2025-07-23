set(vapoursynth_pkgconfig_libs "-lVapourSynth -Wl,-delayload=VapourSynth.dll")
set(vapoursynth_script_pkgconfig_libs "-lVSScript -Wl,-delayload=VSScript.dll")
if(CLANG_PACKAGES_LTO)
    set(cargo_lto_rustflags "CARGO_PROFILE_RELEASE_LTO=thin
    RUSTFLAGS='-Ctarget-cpu=${GCC_ARCH} -Cforce-frame-pointers=no -Ccontrol-flow-guard=yes -Clinker-plugin-lto=yes -Cforce-frame-pointers=no -Clto=thin -Cllvm-args=-fp-contract=fast -Zmerge-functions=aliases -Zcombine-cgu=yes -Zfunction-sections=yes -Zno-unique-section-names=yes -Zhas-thread-local=yes -Ztls-model=local-exec -Zthreads=${CPU_COUNT}'")
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(dlltool_image "i386:x86-64")
    set(openssl_target "mingw64")
    set(libvpx_target "x86_64-win64-gcc")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(mimalloc_macro "-D_M_X64")
    if(GCC_ARCH_HAS_AVX)
        set(aom_vpx_sse2avx
            COMMAND ${EXEC} sed -i [['/%macro INIT_XMM/,/%endmacro/ s/%assign avx_enabled 0/%assign avx_enabled 1/']] <SOURCE_DIR>/third_party/x86inc/x86inc.asm
        )
        set(x265_sse2avx
            COMMAND ${EXEC} ninja -C <BINARY_DIR>/12b common/CMakeFiles/common.dir/x86/intrapred16.asm.obj
            COMMAND ${EXEC} sed -i [['/%macro INIT_XMM/,/%endmacro/ s/%assign avx_enabled 0/%assign avx_enabled 1/']] <SOURCE_DIR>/source/common/x86/x86inc.asm
        )
        set(novzeroupper
            COMMAND ${EXEC} sed -i [['s/%define vzeroupper_required .*/%define vzeroupper_required 0/']]
        )
    else()
        set(novzeroupper
            COMMAND true
        )
    endif()
elseif(TARGET_CPU STREQUAL "aarch64")
    set(dlltool_image "arm64")
    set(openssl_target "mingwarm64")
    set(libvpx_target "arm64-win64-gcc")
    set(novzeroupper
        COMMAND true
    )
endif()

set(cmake_conf_args
    -GNinja
    -DCMAKE_BUILD_TYPE=Release
    -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
    -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
    -DBUILD_SHARED_LIBS=OFF
    -DBUILD_TESTING=OFF
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
)
set(meson_conf_args
    --cross-file=${MESON_CROSS}
    --native-file=${MESON_NATIVE}
    -Dbuildtype=release
    -Db_ndebug=true
    -Ddefault_library=static
    -Ddefault_both_libraries=static
    -Dprefer_static=true
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
set(qt_target_features
    -DQT_FEATURE_brotli=ON
    -DQT_FEATURE_cpp_winrt=ON
    -DQT_FEATURE_cxx20=ON
    -DQT_FEATURE_egl=OFF
    -DQT_FEATURE_fontconfig=OFF
    -DQT_FEATURE_harfbuzz=ON
    -DQT_FEATURE_imageformat_jpeg=OFF
    -DQT_FEATURE_intelcet=OFF
    -DQT_FEATURE_jpeg=OFF
    -DQT_FEATURE_libcpp_hardening=OFF
    -DQT_FEATURE_networklistmanager=OFF
    -DQT_FEATURE_openssl_linked=ON
    -DQT_FEATURE_openssl_runtime=OFF
    -DQT_FEATURE_openssl=ON
    -DQT_FEATURE_pkg_config=ON
    -DQT_FEATURE_sql_mysql=OFF
    -DQT_FEATURE_sql_odbc=ON
    -DQT_FEATURE_sql_psql=OFF
    -DQT_FEATURE_stack_protector=OFF
    -DQT_FEATURE_static_runtime=ON
    -DQT_FEATURE_system_freetype=ON
    -DQT_FEATURE_system_harfbuzz=OFF
    -DQT_FEATURE_system_openssl=ON
    -DQT_FEATURE_system_png=ON
    -DQT_FEATURE_system_sqlite=OFF
    -DQT_FEATURE_system_webp=ON
    -DQT_FEATURE_system_zlib=ON
    -DQT_FEATURE_testlib=OFF
    -DQT_FEATURE_vulkan=ON
    -DQT_FEATURE_zstd=ON
)
