ExternalProject_Add(libdvdnav
    DEPENDS libdvdread
    GIT_REPOSITORY https://github.com/zhongflyTeam/libdvdnav.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} ./configure
        ${autoshit_confuck_args}
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FORCE_HIDE_DLLEXPORT=set:1
    BUILD_COMMAND ${MAKE} install-libLTLIBRARIES install-pkgincludeHEADERS install-pkgconfigDATA
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libdvdnav)
cleanup(libdvdnav install)
