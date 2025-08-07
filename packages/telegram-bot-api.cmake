ExternalProject_Add(telegram-bot-api
    DEPENDS
        zlib
        zstd
        openssl
    GIT_REPOSITORY https://github.com/tdlib/telegram-bot-api.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_REMOTE_NAME origin
    GIT_CONFIG "submodule.recurse=true"
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} PATH=$O_PATH ${CMAKE_COMMAND} --fresh -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DTD_ENABLE_LTO=OFF
        -DCCACHE_FOUND=OFF
        -DMEMPROF=OFF
        -DCMAKE_TOOLCHAIN_FILE=""
        -DCMAKE_FIND_ROOT_PATH=/usr
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DTD_ENABLE_DOTNET=OFF
        -DTD_ENABLE_JNI=OFF
    COMMAND ${EXEC} ninja -C <BINARY_DIR> prepare_cross_compiling
    COMMAND ${EXEC} ${CMAKE_COMMAND} --fresh -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DTD_ENABLE_LTO=OFF
        -DCCACHE_FOUND=OFF
        -DMEMPROF=OFF
        -DTD_ENABLE_DOTNET=OFF
        -DTD_ENABLE_JNI=OFF
        -DCMAKE_CROSSCOMPILING=ON
        "-DCMAKE_CXX_FLAGS='-lbrotlicommon -lbrotlidec -lbrotlienc -lzstd -liphlpapi -pthread'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} "FILTER_FLAGS='-Wl,--exclude-libs,ALL'" ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(telegram-bot-api)
cleanup(telegram-bot-api install)
