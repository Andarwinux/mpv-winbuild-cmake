get_property(boost_src TARGET boost PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(libtorrent
    DEPENDS
        boost
        openssl
    GIT_REPOSITORY https://github.com/arvidn/libtorrent.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --shallow-submodules --filter=tree:0"
    GIT_CONFIG "submodule.recurse=true"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG RC_2_0
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBOOST_ROOT=${boost_src}
        -DBoost_INCLUDE_DIR=${boost_src}
        -DBOOST_BUILD_PATH=${boost_src}/tools/build
        -DCMAKE_CXX_STANDARD=20
        -Ddeprecated-functions=OFF
        "-DCMAKE_CXX_FLAGS='-w'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libtorrent)
cleanup(libtorrent install)
