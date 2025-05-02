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
    CONFIGURE_COMMAND ${EXEC} sed -i [['/find_library/d']] <SOURCE_DIR>/meson.build
    COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Denable_tools=false
        -Dbdj_jar=disabled
        -Djava9=false
        -Dfreetype=enabled
        -Dlibxml2=enabled
        "-Dc_args='-Ddec_init=libbluray_dec_init'"
    BUILD_COMMAND ${EXEC} HIDE=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
            COMMAND ${EXEC} sed -i [['s/-lbluray/-lbluray -lgdi32/']] ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/libbluray.pc
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libbluray)
cleanup(libbluray install)
