ExternalProject_Add(mujs
    DEPENDS
        meson-wrap
    GIT_REPOSITORY https://codeberg.org/ccxvii/mujs.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory ${src_meson_wrap}/subprojects/packagefiles/mujs <SOURCE_DIR>
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_UNWIND_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel,runtime
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mujs)
cleanup(mujs install)
