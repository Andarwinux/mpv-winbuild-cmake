ExternalProject_Add(mimalloc
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/Andarwinux/mimalloc.git
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG dev2
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DMI_BUILD_SHARED=ON
        -DMI_BUILD_STATIC=OFF
        -DMI_BUILD_OBJECT=OFF
        -DMI_BUILD_TESTS=OFF
        -DMI_INSTALL_TOPLEVEL=ON
        -DMI_OVERRIDE=ON
        -DMI_SKIP_COLLECT_ON_EXIT=ON
        -DMI_USE_CXX=ON
        -DBUILD_SHARED_LIBS=ON
        -DCMAKE_UNITY_BUILD=ON
        -DCMAKE_UNITY_BUILD_BATCH_SIZE=0
        -DMI_OPT_ARCH=OFF
        -DCMAKE_SHARED_LIBRARY_PREFIX_CXX=''
        "-DCMAKE_C_FLAGS='-DMI_DEBUG=0 ${mimalloc_macro}'"
        "-DCMAKE_CXX_FLAGS='-DMI_DEBUG=0 ${mimalloc_macro}'"
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> LE_TLS=0 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mimalloc)
cleanup(mimalloc install)
