get_property(boost_src TARGET boost PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(qbittorrent
    DEPENDS
        libtorrent
        qt6-qtbase
        qt6-qttools
        qt6-qtsvg
        boost
    GIT_REPOSITORY https://github.com/c0re100/qBittorrent-Enhanced-Edition.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG v5_1_x
    UPDATE_COMMAND ""
    PATCH_COMMAND ${EXEC} ${GIT_EXECUTABLE} am --3way ${CMAKE_CURRENT_SOURCE_DIR}/qbittorrent-*.patch
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${qt_target_features}
        ${qt_force_skip_check}
        -DBOOST_ROOT=${boost_src}
        -DBoost_INCLUDE_DIR=${boost_src}
        -DBOOST_BUILD_PATH=${boost_src}/tools/build
        -DQT6=ON
        -DCMAKE_PREFIX_PATH=${MINGW_INSTALL_PREFIX}/qt6
        -DQT_HOST_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DTESTING=OFF
        -DSTACKTRACE=OFF
        "-DCMAKE_CXX_FLAGS='-lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd -DQ_DECL_VECTORCALL=__vectorcall -DQT_VECTORCALL=__vectorcall'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/qbittorrent.exe ${MINGW_INSTALL_PREFIX}/bin/qbittorrent.exe
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qbittorrent)
cleanup(qbittorrent install)
