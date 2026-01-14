ExternalProject_Add(dav1d
    DEPENDS
        xxhash
    GIT_REPOSITORY https://github.com/videolan/dav1d.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    PATCH_COMMAND ${EXEC} ${GIT_EXECUTABLE} am --3way ${CMAKE_CURRENT_SOURCE_DIR}/dav1d-*.patch
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Denable_tools=false
        -Denable_tests=false
        -Dxxhash_muxer=enabled
        -Dtrim_dsp=true
        "-Dc_args='-DXXH_ENABLE_AUTOVECTORIZE'"
    ${novzeroupper} <BINARY_DIR>/source/${package}/src/ext/x86/x86inc.asm
    COMMAND ${EXEC} sed -i [['/__USE_MINGW_ANSI_STDIO/d']] <BINARY_DIR>/build/config.h
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(dav1d)
cleanup(dav1d install)
