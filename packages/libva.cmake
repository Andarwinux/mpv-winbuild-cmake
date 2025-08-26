ExternalProject_Add(libva
    GIT_REPOSITORY https://github.com/intel/libva.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ""
    COMMAND ${EXEC} sed -i [['s/shared_library/library/g']] <SOURCE_DIR>/va/meson.build
    COMMAND ${EXEC} sed -i  [['/sysconfdir/d']] <SOURCE_DIR>/va/meson.build
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Denable_docs=false
        -Ddisable_drm=true
        -Dwith_x11=no
        -Dwith_glx=no
        -Dwith_wayland=no
        "-Dc_args='-DSYSCONFDIR=__BASE_FILE__ -DVA_DRIVERS_PATH=__BASE_FILE__'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libva)
cleanup(libva install)
