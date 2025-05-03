ExternalProject_Add(libdvdread
    DEPENDS libdvdcss
    GIT_REPOSITORY https://github.com/zhongflyTeam/libdvdread.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} sed -i [['s/import(.*/false/']] <SOURCE_DIR>/meson.build
    COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dlibdvdcss=enabled
    BUILD_COMMAND ${EXEC} HIDE=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libdvdread)
cleanup(libdvdread install)
