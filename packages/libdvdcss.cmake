ExternalProject_Add(libdvdcss
    GIT_REPOSITORY https://github.com/zhongflyTeam/libdvdcss.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
        --disable-doc
    BUILD_COMMAND ${MAKE} HIDE=1 install-libLTLIBRARIES install-pkgincludeHEADERS install-pkgconfigDATA
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libdvdcss)
cleanup(libdvdcss install)
