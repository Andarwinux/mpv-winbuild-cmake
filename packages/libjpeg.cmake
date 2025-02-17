ExternalProject_Add(libjpeg
    GIT_REPOSITORY https://github.com/libjpeg-turbo/libjpeg-turbo.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DENABLE_STATIC=ON
        -DENABLE_SHARED=OFF
        -DWITH_TURBOJPEG=OFF
    BUILD_COMMAND ${EXEC} UNWIND=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libjpeg)
cleanup(libjpeg install)
