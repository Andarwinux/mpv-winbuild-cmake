ExternalProject_Add(qt6-qtsvg
    DEPENDS
        qt6-qtbase
    GIT_REPOSITORY https://github.com/qt/qtsvg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG 6.8
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_WITH_PCH=ON
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}/qt6
        -DCMAKE_PREFIX_PATH=${MINGW_INSTALL_PREFIX}/qt6
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_FEATURE_brotli=ON
        -DQT_FEATURE_cpp_winrt=ON
        -DQT_FEATURE_cxx20=ON
        -DQT_FEATURE_egl=OFF
        -DQT_FEATURE_testlib=OFF
        -DQT_FEATURE_networklistmanager=OFF
        -DQT_FEATURE_intelcet=OFF
        -DQT_FEATURE_fontconfig=OFF
        -DQT_FEATURE_openssl=ON
        -DQT_FEATURE_pkg_config=ON
        -DQT_FEATURE_static_runtime=ON
        -DQT_FEATURE_system_freetype=ON
        -DQT_FEATURE_harfbuzz=ON
        -DQT_FEATURE_system_harfbuzz=OFF
        -DQT_FEATURE_system_jpeg=ON
        -DQT_FEATURE_system_openssl=ON
        -DQT_FEATURE_system_png=ON
        -DQT_FEATURE_system_webp=ON
        -DQT_FEATURE_system_zlib=ON
        -DQT_FEATURE_system_sqlite=OFF
        -DQT_FEATURE_vulkan=ON
        -DQT_FEATURE_zstd=ON
        -DQT_FEATURE_sql_odbc=ON
        -DQT_FEATURE_sql_mysql=OFF
        -DQT_FEATURE_sql_psql=OFF
        -DQT_HOST_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=OFF
        -DTEST_opensslv30=TRUE
        "-DCMAKE_C_FLAGS='-lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
        "-DCMAKE_CXX_FLAGS='-lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
    BUILD_COMMAND ${EXEC} EXCEP=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qt6-qtsvg)
cleanup(qt6-qtsvg install)
