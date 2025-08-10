ExternalProject_Add(meson-wrap
    GIT_REPOSITORY https://github.com/mesonbuild/wrapdb.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone subprojects/packagefiles/luajit subprojects/packagefiles/mujs subprojects/packagefiles/sqlite3"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(meson-wrap)
cleanup(meson-wrap install)
get_property(src_meson_wrap TARGET meson-wrap PROPERTY _EP_SOURCE_DIR)
