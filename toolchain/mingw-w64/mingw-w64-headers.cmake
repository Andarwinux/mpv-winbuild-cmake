ExternalProject_Add(mingw-w64-headers
    DEPENDS
        mingw-w64
        llvm-wrapper
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${MINGW_SRC}
    CONFIGURE_COMMAND <SOURCE_DIR>/mingw-w64-headers/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --enable-sdk=all
        --enable-idl
        --with-default-msvcrt=ucrt
    BUILD_COMMAND ""
    INSTALL_COMMAND make install
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/include/windows.h ${MINGW_INSTALL_PREFIX}/include/Windows.h
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/include/ntsecapi.h ${MINGW_INSTALL_PREFIX}/include/Ntsecapi.h
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/include/shlobj.h ${MINGW_INSTALL_PREFIX}/include/Shlobj.h
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/include/shellapi.h ${MINGW_INSTALL_PREFIX}/include/Shellapi.h
            COMMAND ${CMAKE_COMMAND} -E copy ${MINGW_INSTALL_PREFIX}/include/objbase.h ${MINGW_INSTALL_PREFIX}/include/Objbase.h
            COMMAND ${CMAKE_COMMAND} -E make_directory ${MINGW_INSTALL_PREFIX}/lib
            COMMAND ${EXEC} ${TARGET_ARCH}-dlltool -d ${CMAKE_CURRENT_SOURCE_DIR}/mingw-w64/mingw-w64-math.def -l ${MINGW_INSTALL_PREFIX}/lib/ucrtmath.a
            COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/headers/icu.h ${MINGW_INSTALL_PREFIX}/include/
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(mingw-w64-headers install)
