ExternalProject_Add(opencl-header
    GIT_REPOSITORY https://github.com/KhronosGroup/OpenCL-Headers.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG main
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DCMAKE_INSTALL_DATADIR=${MINGW_INSTALL_PREFIX}/lib
        -DOPENCL_HEADERS_BUILD_TESTING=OFF
        -DOPENCL_HEADERS_BUILD_CXX_TESTS=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
force_rebuild_git(opencl-header)
cleanup(opencl-header install)

