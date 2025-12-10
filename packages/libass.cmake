ExternalProject_Add(libass
    DEPENDS
        harfbuzz
        freetype2
        fribidi
        libiconv
        fontconfig
        libunibreak
    GIT_REPOSITORY https://github.com/rcombs/libass.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG threading
    UPDATE_COMMAND ""
    PATCH_COMMAND ${EXEC} ${GIT_EXECUTABLE} am --3way ${CMAKE_CURRENT_SOURCE_DIR}/libass-*.patch
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Dfontconfig=enabled
        -Ddirectwrite=enabled
        -Dasm=enabled
        -Dlibunibreak=enabled
        -Dthreads=enabled
        -Dtest=disabled
        -Dcompare=disabled
        -Dprofile=disabled
        -Dfuzz=disabled
        -Dcheckasm=disabled
    ${novzeroupper} <BINARY_DIR>/source/${package}/libass/x86/x86inc.asm
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FULL_DEBUGINFO=set:1
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libass)
cleanup(libass install)
