ExternalProject_Add(zstd
    GIT_REPOSITORY https://github.com/facebook/zstd.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !doc !contrib"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG dev
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>/build/meson
        ${meson_conf_args}
        -Dlegacy_level=0
        -Ddebug_level=0
        -Dbin_programs=false
        -Dzlib=disabled
        -Dlzma=disabled
        -Dlz4=disabled
        "-Dc_args='-DXXH_ENABLE_AUTOVECTORIZE'"
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(zstd)
cleanup(zstd install)
