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
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} sed -i [['/find_library/d']] <BINARY_DIR>/source/${package}/meson.build
    COMMAND ${EXEC} sed -i [['/__USE_MINGW_ANSI_STDIO/d']] <BINARY_DIR>/source/${package}/meson.build
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Denable_tools=false
        -Dbdj_jar=disabled
        -Dfreetype=enabled
        -Dlibxml2=enabled
        "-Dc_args='-Ddec_init=libbluray_dec_init -Ddir_open_default=libbluray_dir_open_default -Dfile_open_default=libbluray_file_open_default'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FORCE_HIDE_DLLEXPORT=set:1
    BUILD_COMMAND meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libbluray)
cleanup(libbluray install)
