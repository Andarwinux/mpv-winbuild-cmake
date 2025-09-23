ExternalProject_Add(openlibm
    DEPENDS
        mingw-w64-crt
    GIT_REPOSITORY https://github.com/Andarwinux/openlibm.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DCMAKE_INSTALL_LIBDIR=${MINGW_INSTALL_PREFIX}/lib
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
            COMMAND ${EXEC} ${TARGET_ARCH}-llvm-ar d ${MINGW_INSTALL_PREFIX}/lib/libopenlibm.a e_pow.c.obj
            COMMAND ${EXEC} ${TARGET_ARCH}-llvm-ar d ${MINGW_INSTALL_PREFIX}/lib/libopenlibm.a e_powf.c.obj
            COMMAND ${EXEC} ${TARGET_ARCH}-llvm-ar d ${MINGW_INSTALL_PREFIX}/lib/libopenlibm.a s_cpow.c.obj
            COMMAND ${EXEC} ${TARGET_ARCH}-llvm-ar d ${MINGW_INSTALL_PREFIX}/lib/libopenlibm.a s_cpowf.c.obj
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(openlibm)
cleanup(openlibm install)
