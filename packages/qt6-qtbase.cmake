ExternalProject_Add(qt6-qtbase
    DEPENDS
        brotli
        freetype2
        zlib
        zstd
        vulkan
        libpng
        openssl
        bzip2
    GIT_REPOSITORY https://github.com/qt/qtbase.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !examples"
    GIT_TAG dev
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>/qthost
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/qt6
        -DBUILD_WITH_PCH=ON
        -DINPUT_opengl=no
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_DOCS=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_FEATURE_accessibility=OFF
        -DQT_FEATURE_backtrace=OFF
        -DQT_FEATURE_egl=OFF
        -DQT_FEATURE_glib=OFF
        -DQT_FEATURE_glibc_fortify_source=OFF
        -DQT_FEATURE_gssapi=OFF
        -DQT_FEATURE_gui=OFF
        -DQT_FEATURE_icu=OFF
        -DQT_FEATURE_intelcet=OFF
        -DQT_FEATURE_libcpp_hardening=OFF
        -DQT_FEATURE_network=OFF
        -DQT_FEATURE_opengl_desktop=OFF
        -DQT_FEATURE_opengl_dynamic=OFF
        -DQT_FEATURE_opengl=OFF
        -DQT_FEATURE_opengles2=OFF
        -DQT_FEATURE_openssl=OFF
        -DQT_FEATURE_sql=OFF
        -DQT_FEATURE_stack_protector=OFF
        -DQT_FEATURE_testlib=OFF
        -DQT_FEATURE_trivial_auto_var_init_pattern=OFF
        -DQT_FEATURE_xcb_xlib=OFF
        -DQT_FEATURE_xcb=OFF
        -DQT_FEATURE_xkbcommon=OFF
        -DQT_FEATURE_xml=OFF
        -DQT_FEATURE_zstd=OFF
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=ON
        -DQT_USE_CCACHE=OFF
        "-DCMAKE_C_FLAGS='-Wno-unused-command-line-argument -g0 -fno-ident -fno-temp-file -fno-plt -Wa,--crel,--allow-experimental-crel -march=native -O3 -fno-semantic-interposition -fvisibility=hidden -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec -Xclang -fno-pch-timestamp'"
        "-DCMAKE_CXX_FLAGS='-Wno-unused-command-line-argument -g0 -fno-ident -fno-temp-file -fno-plt -Wa,--crel,--allow-experimental-crel -march=native -O3 -fno-semantic-interposition -fvisibility=hidden -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec -Xclang -fno-pch-timestamp'"
        "-DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=lld -Wl,-Bsymbolic,--build-id=none,-s,-O3,--icf=all,--gc-sections,-zpack-relative-relocs,-zcommon-page-size=2097152,-zmax-page-size=2097152,-zseparate-loadable-segments'"
    COMMAND ${EXEC} ninja -C <BINARY_DIR>/qthost install
    COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${qt_target_features}
        -DBUILD_WITH_PCH=ON
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}/qt6
        -DCMAKE_PREFIX_PATH=${MINGW_INSTALL_PREFIX}
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_BUILD_DOCS=OFF
        -DQT_HOST_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=OFF
        -DTEST_opensslv30=TRUE
        "-DCMAKE_C_FLAGS='-lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
        "-DCMAKE_CXX_FLAGS='-lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
    BUILD_COMMAND ${EXEC} EXCEP=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qt6-qtbase)
cleanup(qt6-qtbase install)
