ExternalProject_Add(mingw-w64-crt
    DEPENDS
        mingw-w64
        mingw-w64-headers
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${MINGW_SRC}
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/mingw-w64-crt/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --with-sysroot=${CMAKE_INSTALL_PREFIX}
        --with-default-msvcrt=ucrt
        --enable-wildcard
        --enable-cfguard
        ${crt_lib}
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _LTO_ENABLED=set:0
        _PGO_ENABLED=set:0
        _CODEVIEW_ENABLED=set:0
        _NO_DEBUGINFO=set:1
        _IS_UNWIND_ALLOWED=set:1
        _NOCCACHE=set:1
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libpowrprof.a ${MINGW_INSTALL_PREFIX}/lib/libPowrProf.a
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libiphlpapi.a ${MINGW_INSTALL_PREFIX}/lib/libIphlpapi.a
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libicu.a ${MINGW_INSTALL_PREFIX}/lib/libicuin.a
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libicu.a ${MINGW_INSTALL_PREFIX}/lib/libicuuc.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(mingw-w64-crt install)
