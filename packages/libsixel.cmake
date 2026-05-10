ExternalProject_Add(libsixel
    DEPENDS
        lcms2
    GIT_REPOSITORY https://github.com/saitoha/libsixel.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !php !python !perl !wic !quicklook-extension !assessment !build-aux !m4 !tests !fuzz !examples !images images/meson.build fuzz/meson.build examples/meson.build python/meson.build assessment/meson.build"
    PATCH_COMMAND ${EXEC} ${GIT_EXECUTABLE} am --3way ${CMAKE_CURRENT_SOURCE_DIR}/libsixel-*.patch
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG develop
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/fuzz/meson.build
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/examples/meson.build
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/images/meson.build
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/python/meson.build
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/assessment/meson.build
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Djpeg=disabled
        -Dpng=disabled
        -Dtiff=disabled
        -Dwebp=disabled
        -Dlibrsvg=disabled
        -Dwinhttp=disabled
        -Dwinpthread=disabled
        -Dthreads=enabled
        -Dlcms2=enabled
        -Dsimd=enabled
        -Dimg2sixel=disabled
        -Dsixel2png=disabled
        -Dtests=false
        -Dunity=on
        -Dunity_size=32768
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FORCE_HIDE_DLLEXPORT=set:1
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory ${MINGW_INSTALL_PREFIX}/include/sixel ${MINGW_INSTALL_PREFIX}/include
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libsixel)
cleanup(libsixel install)
