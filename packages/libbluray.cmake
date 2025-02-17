ExternalProject_Add(libbluray
    DEPENDS
        libudfread
        freetype2
    GIT_REPOSITORY https://code.videolan.org/videolan/libbluray.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
        --disable-examples
        --disable-doxygen-doc
        --disable-bdjava-jar
        --without-libxml2
        --without-fontconfig
        CFLAGS='-Ddec_init=libbluray_dec_init'
    BUILD_COMMAND ${MAKE} HIDE=1
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libbluray)
cleanup(libbluray install)
