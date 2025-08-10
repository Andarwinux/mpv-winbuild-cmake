ExternalProject_Add(libunibreak
    GIT_REPOSITORY https://github.com/adah1972/libunibreak.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory ${src_meson_wrap}/subprojects/packagefiles/libunibreak <SOURCE_DIR>
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dtests=disabled
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libunibreak)
cleanup(libunibreak install)
