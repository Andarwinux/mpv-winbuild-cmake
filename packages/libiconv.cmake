# libarchive required 3rd party iconv.pc when linking
set(VERSION "1.18")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libiconv.pc.in ${CMAKE_CURRENT_BINARY_DIR}/libiconv.pc @ONLY)

ExternalProject_Add(libiconv
    GIT_REPOSITORY https://github.com/win-iconv/win-iconv.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DWIN_ICONV_BUILD_SHARED=OFF
        -DWIN_ICONV_BUILD_EXECUTABLE=OFF
        -DDEFAULT_LIBICONV_DLL=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_Doxygen=ON
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(libiconv install-pc
    DEPENDEES install
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/libiconv.pc ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/iconv.pc
)

force_rebuild_git(libiconv)
cleanup(libiconv install-pc)
