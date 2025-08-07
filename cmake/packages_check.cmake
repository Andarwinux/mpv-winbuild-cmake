set(vapoursynth_pkgconfig_libs "-lVapourSynth -Wl,-delayload=VapourSynth.dll")
set(vapoursynth_script_pkgconfig_libs "-lVSScript -Wl,-delayload=VSScript.dll")

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
    -DCMAKE_C_STANDARD=17
    -DCMAKE_CXX_STANDARD=20
    -DCMAKE_POLICY_VERSION_MINIMUM=3.5
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
    -DQT_FEATURE_printsupport=OFF
    -DQT_FEATURE_qmake=OFF
    -DQT_FEATURE_relocatable=ON
    -DQT_FEATURE_sql_mysql=OFF
    -DQT_FEATURE_sql_odbc=ON
    -DQT_FEATURE_sql_psql=OFF
    -DQT_FEATURE_stack_protector=OFF
    -DQT_FEATURE_static_runtime=ON
    -DQT_FEATURE_system_freetype=ON
    -DQT_FEATURE_system_harfbuzz=ON
    -DQT_FEATURE_system_openssl=ON
    -DQT_FEATURE_system_png=ON
    -DQT_FEATURE_system_sqlite=OFF
    -DQT_FEATURE_system_webp=ON
    -DQT_FEATURE_system_zlib=ON
    -DQT_FEATURE_test_gui=OFF
    -DQT_FEATURE_testlib=OFF
    -DQT_FEATURE_trivial_auto_var_init_pattern=OFF
    -DQT_FEATURE_vulkan=ON
    -DQT_FEATURE_wasmdeployqt=OFF
    -DQT_FEATURE_winsdkicu=ON
    -DQT_FEATURE_zstd=ON
)

set(qt_force_skip_check
    -DHAVE_atomicfptr=ON
    -DHAVE_cxx_std_async_noncopyable=ON
    -DHAVE_cxx17_filesystem=ON
    -DHAVE_cxx20_format=ON
    -DHAVE_d2d1_1=ON
    -DHAVE_d2d1=ON
    -DHAVE_directwrite=ON
    -DHAVE_directwrite3=ON
    -DHAVE_dtls=ON
    -DHAVE_evdev=OFF
    -DHAVE_fsnotify=OFF
    -DHAVE_GLESv2=OFF
    -DHAVE_glibc=OFF
    -DHAVE_inotify=OFF
    -DHAVE_LD_VERSION_SCRIPT=OFF
    -DHAVE_LIBRESOLV_FUNCTIONS=OFF
    -DHAVE_linkat=OFF
    -DHAVE_linuxfb=OFF
    -DHAVE_ocsp=OFF
    -DHAVE_OpenGLES=OFF
    -DHAVE_opensslv11_headers=OFF
    -DHAVE_opensslv11=OFF
    -DHAVE_poll=OFF
    -DHAVE_pollts=OFF
    -DHAVE_posix_fallocate=OFF
    -DHAVE_posix_sem=OFF
    -DHAVE_ppoll=OFF
    -DHAVE_sctp=OFF
    -DHAVE_STDATOMIC=ON
    -DHAVE_sysv_sem=OFF
    -DHAVE_using_stdlib_libcpp=ON
    -DHAVE_vxworksevdev=OFF
    -DTEST_enable_new_dtags=OFF
    -DTEST_gdb_index=OFF
    -DTEST_LOONGARCHSIMD_LASX=OFF
    -DTEST_LOONGARCHSIMD_LSX=OFF
    -DTEST_optimize_debug=ON
    -DTEST_stack_protector=OFF
    -DTEST_trivial_auto_var_init_pattern=OFF
    -DTEST_use_bfd_linker=OFF
    -DTEST_use_gold_linker=OFF
    -DTEST_use_lld_linker=OFF
    -DTEST_use_mold_linker=OFF
    -DCMAKE_DISABLE_FIND_PACKAGE_ATSPI2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Backtrace=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Cups=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_DB2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_DirectFB=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_EGL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Fontconfig=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_gbm=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GLESv2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GLIB2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GSSAPI=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GTK3=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_ICU=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Interbase=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_JeMalloc=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_JPEG=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libb2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libdrm=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libinput=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libproxy=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libsystemd=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libudev=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_LTTngUST=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Mimer=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Mtdev=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_MySQL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Oracle=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_PlatformGraphics=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_PostgreSQL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_RenderDoc=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Slog2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_SQLite3=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Tslib=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Client=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Cursor=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Egl=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Server=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WaylandScanner=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapDBus1=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapResolv=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapRt=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemDoubleConversion=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemJpeg=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemMd4c=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemPCRE2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_X11_XCB=ON
)

set(qthost_force_skip_check
    -DCMAKE_HAVE_LIBC_PTHREAD=ON
    -DHAVE_atomicfptr=ON
    -DHAVE_cxx_std_async_noncopyable=ON
    -DHAVE_cxx17_filesystem=ON
    -DHAVE_cxx20_format=ON
    -DHAVE_LD_VERSION_SCRIPT=ON
    -DHAVE_opensslv11_headers=OFF
    -DHAVE_opensslv11=OFF
    -DHAVE_opensslv30_headers=OFF
    -DHAVE_opensslv30=OFF
    -DHAVE_STDATOMIC=ON
    -DHAVE_using_stdlib_libcpp=OFF
    -DHAVE_winsdkicu=OFF
    -DTEST_enable_new_dtags=ON
    -DTEST_gdb_index=ON
    -DTEST_LOONGARCHSIMD_LASX=OFF
    -DTEST_LOONGARCHSIMD_LSX=OFF
    -DTEST_opensslv11_headers=OFF
    -DTEST_opensslv11=OFF
    -DTEST_opensslv30_headers=OFF
    -DTEST_opensslv30=OFF
    -DTEST_optimize_debug=ON
    -DTEST_relro_now_linker=ON
    -DTEST_stack_protector=OFF
    -DTEST_trivial_auto_var_init_pattern=OFF
    -DTEST_use_bfd_linker=OFF
    -DTEST_use_gold_linker=OFF
    -DTEST_use_lld_linker=ON
    -DTEST_use_mold_linker=OFF
    -DCMAKE_DISABLE_FIND_PACKAGE_ATSPI2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Backtrace=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Cups=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_DB2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_DirectFB=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_EGL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Fontconfig=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_gbm=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GLESv2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GLIB2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GSSAPI=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_GTK3=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_ICU=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Interbase=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_JeMalloc=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_JPEG=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libb2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libdrm=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libinput=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libproxy=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libsystemd=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libudev=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Libudev=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_LTTngUST=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Mimer=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Mtdev=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_MySQL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_OpenSSL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Oracle=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_PlatformGraphics=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_PostgreSQL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6Network=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6OpenGL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6OpenGLWidgets=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6PrintSupport=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6Qml=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6QmlLSPrivate=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6Quick=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6QuickLayouts=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6QuickWidgets=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6Sql=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6Widgets=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Qt6Xml=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_RenderDoc=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Slog2=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_SQLite3=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Tslib=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Client=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Cursor=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Egl=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland_Server=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_Wayland=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WaylandScanner=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapBacktrace=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapDBus1=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapLibClang=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapOpenSSL=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapOpenSSLHeaders=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapPNG=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapResolv=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapRt=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemDoubleConversion=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemJpeg=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemMd4c=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapSystemPNG=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_WrapZSTD=ON
    -DCMAKE_DISABLE_FIND_PACKAGE_X11_XCB=ON
)

set(trim_path
    COMMAND ${EXEC} sed -i
    -e 's|${MINGW_INSTALL_PREFIX}|${TARGET_ARCH}|g'
    -e 's|${SINGLE_SOURCE_LOCATION}|soucre|g'
    -e 's|${PROJECT_BINARY_DIR}|build|g'
)

if(QT_DISABLE_CCACHE)
    set(qt_disable_ccache 1)
    set(qt_unity
        -DQT_UNITY_BUILD=ON
        -DQT_UNITY_BUILD_BATCH_SIZE=16
    )
else()
    set(qt_disable_ccache 0)
    set(qt_unity -DQT_UNITY_BUILD=OFF)
endif()
