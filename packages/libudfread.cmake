ExternalProject_Add(libudfread
    GIT_REPOSITORY https://code.videolan.org/videolan/libudfread.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libudfread)
cleanup(libudfread install)
