ExternalProject_Add(sqlite
    DEPENDS
        zlib
    URL https://www.sqlite.org/2024/sqlite-autoconf-3470200.tar.gz
    URL_HASH SHA3_256=52cd4a2304b627abbabe1a438ba853d0f6edb8e2774fcb5773c7af11077afe94
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(sqlite install)
