ExternalProject_Add(rubberband
    DEPENDS
        libsamplerate
        sleef
    GIT_REPOSITORY https://github.com/breakfastquay/rubberband.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG default
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dfft=sleef
        -Dresampler=libsamplerate
        -Djni=disabled
        -Dcmdline=disabled
        -Dtests=disabled
        "-Dc_args='-DNO_EXCEPTIONS -DLACK_SINCOS'"
        "-Dcpp_args='-DNO_EXCEPTIONS -DLACK_SINCOS'"
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> EXCEP=1 meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(rubberband)
cleanup(rubberband install)
