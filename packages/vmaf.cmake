ExternalProject_Add(vmaf
    GIT_REPOSITORY https://github.com/Netflix/vmaf.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !resource !matlab !libvmaf/tools libvmaf/tools/meson.build"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    COMMAND ${EXEC} echo > <SOURCE_DIR>/libvmaf/tools/meson.build
    COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>/libvmaf
        ${meson_conf_args}
        -Dbuilt_in_models=true
        -Denable_tests=false
        -Denable_docs=false
        -Denable_avx512=true
        -Denable_float=true
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> EXCEP=1 meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(vmaf)
cleanup(vmaf install)
