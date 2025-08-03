ExternalProject_Add(mingw-w64-crt
    DEPENDS
        mingw-w64
        mingw-w64-headers
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${MINGW_SRC}
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/mingw-w64-crt/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --with-sysroot=${CMAKE_INSTALL_PREFIX}
        --with-default-msvcrt=ucrt
        --enable-wildcard
        --enable-cfguard
        ${crt_lib}
    BUILD_COMMAND ${MAKE} LTO=0 PGO=0 GC=0 UNWIND=1 FULL_DBG=1
    INSTALL_COMMAND ${MAKE} install
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libpowrprof.a ${MINGW_INSTALL_PREFIX}/lib/libPowrProf.a
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libiphlpapi.a ${MINGW_INSTALL_PREFIX}/lib/libIphlpapi.a
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libicu.a ${MINGW_INSTALL_PREFIX}/lib/libicuin.a
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/lib/libicu.a ${MINGW_INSTALL_PREFIX}/lib/libicuuc.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(mingw-w64-crt install)
