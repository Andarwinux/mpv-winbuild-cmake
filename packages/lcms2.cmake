ExternalProject_Add(lcms2
    GIT_REPOSITORY https://github.com/mm2/Little-CMS.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !testbed testbed/meson.build !plugins/*/testbed plugins/*/testbed/meson.build"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/testbed/meson.build
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/plugins/threaded/testbed/meson.build
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/plugins/fast_float/testbed/meson.build
    COMMAND ${EXEC} sed -i [['s/is_visual_studio =.*/is_visual_studio = true/g']] <BINARY_DIR>/source/${package}/meson.build
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Dfastfloat=true
        -Dthreaded=true
        -Djpeg=disabled
        -Dtiff=disabled
        -Dtests=disabled
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(lcms2)
cleanup(lcms2 install)
