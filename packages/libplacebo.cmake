get_property(src_glad TARGET glad PROPERTY _EP_SOURCE_DIR)
get_property(src_fast_float TARGET fast_float PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(libplacebo
    DEPENDS
        fast_float
        glad
        lcms2
        shaderc
        spirv-cross
        vulkan
        xxhash
    GIT_REPOSITORY https://github.com/haasn/libplacebo.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ""
    COMMAND ${CMAKE_COMMAND} -E rm -rf <SOURCE_DIR>/3rdparty/glad
    COMMAND ${CMAKE_COMMAND} -E rm -rf <SOURCE_DIR>/3rdparty/fast_float
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${src_glad} <SOURCE_DIR>/3rdparty/glad
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${src_fast_float} <SOURCE_DIR>/3rdparty/fast_float
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dd3d11=enabled
        -Ddemos=false
        -Ddovi=enabled
        -Dgl-proc-addr=enabled
        -Dlcms=enabled
        -Dlibdovi=disabled
        -Dopengl=enabled
        -Dshaderc=enabled
        -Dvk-proc-addr=enabled
        -Dxxhash=enabled
        -Dvulkan-registry='${MINGW_INSTALL_PREFIX}/share/vulkan/registry/vk.xml'
        -Dvulkan=enabled
        "-Dc_args='-DXXH_ENABLE_AUTOVECTORIZE'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FORCE_HIDE_DLLEXPORT=set:1
        _FULL_DEBUGINFO=set:1
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libplacebo)
cleanup(libplacebo install)
