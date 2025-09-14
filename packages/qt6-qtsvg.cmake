ExternalProject_Add(qt6-qtsvg
    DEPENDS
        qt6-qtbase
    GIT_REPOSITORY https://github.com/qt/qtsvg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG dev
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${qt_target_features}
        ${qt_force_skip_check}
        ${qt_unity}
        -DBUILD_WITH_PCH=ON
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}/qt6
        -DCMAKE_PREFIX_PATH=${MINGW_INSTALL_PREFIX}/qt6
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_HOST_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DTEST_opensslv30=TRUE
        -DCMAKE_MESSAGE_LOG_LEVEL=STATUS
        "-DCMAKE_C_FLAGS='-w -lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
        "-DCMAKE_CXX_FLAGS='-w -lruntimeobject -lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
        _IS_UNWIND_ALLOWED=set:1
        _NOCCACHE=set:${qt_disable_ccache}
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qt6-qtsvg)
cleanup(qt6-qtsvg install)
