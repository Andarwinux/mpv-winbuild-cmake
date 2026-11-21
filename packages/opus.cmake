ExternalProject_Add(opus
    GIT_REPOSITORY https://github.com/xiph/opus.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !doc !tests !training !m4 !dnn/torch !dnn/training_tf2 !cmake"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG main
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/lpcnet_headers.mk
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/lpcnet_sources.mk
    COMMAND ${EXEC} echo > <BINARY_DIR>/source/${package}/dnn/meson.build
    COMMAND ${EXEC} sed -i [['s/, dnn_lib//g']] <BINARY_DIR>/source/${package}/src/meson.build
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Dhardening=false
        -Ddeep-plc=disabled
        -Ddred=disabled
        -Dosce=disabled
        -Dintrinsics=enabled
        -Dfloat-approx=true
        -Dasm=disabled
        -Dextra-programs=disabled
        -Dtests=disabled
        -Ddocs=disabled
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FORCE_HIDE_DLLEXPORT=set:1
        _IS_REASSOC_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(opus)
cleanup(opus install)
