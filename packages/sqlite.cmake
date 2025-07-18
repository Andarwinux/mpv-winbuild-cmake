ExternalProject_Add(sqlite
    DEPENDS
        zlib
    URL https://www.sqlite.org/2025/sqlite-autoconf-3500300.tar.gz
    URL_HASH SHA3_256=c3df1542703a666d3f41bb623e9bed7d6e1dc81c57f0c45e3122403f862c520d
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(sqlite install)
