ExternalProject_Add(aria2
    DEPENDS
        libxml2
        libssh2
        c-ares
        sqlite
        zlib
    GIT_REPOSITORY https://github.com/Andarwinux/aria2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
        --enable-static
        --with-libcares
        --with-libssh2
        --with-libxml2
        --with-sqlite3
        --with-wintls
        --with-libz
    BUILD_COMMAND ${MAKE} EXCEP=1
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(aria2)
cleanup(aria2 install)
