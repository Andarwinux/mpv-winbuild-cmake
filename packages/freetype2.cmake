ExternalProject_Add(freetype2
    DEPENDS
        libpng
        zlib
        brotli
        bzip2
    GIT_REPOSITORY https://github.com/freetype/freetype.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !docs"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dharfbuzz=disabled
        -Dtests=disabled
        -Dbrotli=enabled
        -Dzlib=enabled
        -Dbzip2=enabled
        -Dpng=enabled
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> UNWIND=1 meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(freetype2)
cleanup(freetype2 install)
