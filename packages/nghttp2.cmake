ExternalProject_Add(nghttp2
    GIT_REPOSITORY https://github.com/nghttp2/nghttp2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_CONFIG "submodule.recurse=false"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_STATIC_LIBS=ON
        -DENABLE_APP=OFF
        -DENABLE_FAILMALLOC=OFF
        -DENABLE_LIB_ONLY=ON
        -DENABLE_DOC=OFF
        -DWITH_LIBXML2=OFF
        -DWITH_JEMALLOC=OFF
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(nghttp2)
cleanup(nghttp2 install)
