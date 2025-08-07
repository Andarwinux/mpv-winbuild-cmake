ExternalProject_Add(mingw-w64-winpthreads
    DEPENDS
        mingw-w64-headers
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${MINGW_SRC}
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/mingw-w64-libraries/winpthreads/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --enable-static
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _LTO_ENABLED=set:0
        _PGO_ENABLED=set:0
        _GC_ENABLED=set:0
        _IS_UNWIND_ALLOWED=set:1
        _FULL_DEBUGINFO=set:1
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(mingw-w64-winpthreads install)
