ExternalProject_Add(libbluray
    DEPENDS
        libudfread
        freetype2
        libxml2
    GIT_REPOSITORY https://github.com/zhongflyTeam/libbluray.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} sed -i [['/find_library/d']] <SOURCE_DIR>/meson.build
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Denable_tools=false
        -Dbdj_jar=disabled
        -Djava9=false
        -Dfreetype=enabled
        -Dlibxml2=enabled
        "-Dc_args='-Ddec_init=libbluray_dec_init'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FORCE_HIDE_DLLEXPORT=set:1
    BUILD_COMMAND meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libbluray)
cleanup(libbluray install)
