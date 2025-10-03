get_property(src_opus_dnn TARGET opus-dnn PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(opus
    DEPENDS
        opus-dnn
    GIT_REPOSITORY https://github.com/xiph/opus.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG main
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND bash -c "cp ${src_opus_dnn}/*.h ${src_opus_dnn}/*.c <BINARY_DIR>/source/${package}/dnn"
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Dhardening=false
        -Ddeep-plc=enabled
        -Ddred=enabled
        -Dosce=enabled
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
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ${CMAKE_COMMAND} -E rm -rf ${src_opus_dnn}/models
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(opus)
cleanup(opus install)
