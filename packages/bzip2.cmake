ExternalProject_Add(bzip2
    GIT_REPOSITORY https://gitlab.com/bzip2/bzip2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CONFIG "submodule.recurse=false"
    GIT_SUBMODULES ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DENABLE_LIB_ONLY=ON
        -DENABLE_SHARED_LIB=OFF
        -DENABLE_STATIC_LIB=ON
        -DENABLE_TESTS=OFF
        -DCMAKE_UNITY_BUILD=ON
        -DUNITY_BUILD_BATCH_SIZE=0
        -DCMAKE_UNITY_BUILD_BATCH_SIZE=0
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libbz2_static.a ${MINGW_INSTALL_PREFIX}/lib/libbz2.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(bzip2)
cleanup(bzip2 install)
