ExternalProject_Add(mingw-w64-crt
    DEPENDS
        mingw-w64
        mingw-w64-headers
        llvm-wrapper
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
    BUILD_COMMAND ${MAKE} LTO=0 PGO=0 GC=0 UNWIND=1 FP80=1
    INSTALL_COMMAND ${MAKE} install
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/lib/libpowrprof.a ${MINGW_INSTALL_PREFIX}/lib/libPowrProf.a
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/lib/libiphlpapi.a ${MINGW_INSTALL_PREFIX}/lib/libIphlpapi.a
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/shlobj.h ${MINGW_INSTALL_PREFIX}/include/Shlobj.h
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/shellapi.h ${MINGW_INSTALL_PREFIX}/include/Shellapi.h
            COMMAND ${EXEC} cp ${MINGW_INSTALL_PREFIX}/include/objbase.h ${MINGW_INSTALL_PREFIX}/include/Objbase.h
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(mingw-w64-crt autoreconf
    DEPENDEES download update patch
    DEPENDERS configure
    COMMAND ${EXEC} autoreconf -fi
    WORKING_DIRECTORY <SOURCE_DIR>/mingw-w64-crt
    LOG 1
)

cleanup(mingw-w64-crt install)
