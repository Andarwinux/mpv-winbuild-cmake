get_property(src_graphengine TARGET graphengine PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(libzimg
    DEPENDS
        graphengine
    GIT_REPOSITORY https://github.com/robxnano/zimg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG meson
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>/source/${package}
    COMMAND ${EXEC} sed -i [['s/Windows.h/windows.h/g']] <BINARY_DIR>/source/${package}/src/zimg/common/arm/cpuinfo_arm.cpp
    COMMAND ${CMAKE_COMMAND} -E rm -rf <BINARY_DIR>/source/${package}/graphengine
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${src_graphengine} <BINARY_DIR>/source/${package}/graphengine
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR>/build <BINARY_DIR>/source/${package}
        ${meson_conf_args}
        -Dcpp_rtti=true
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
        _FORCE_HIDE_DLLEXPORT=set:1
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR>/build --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libzimg)
cleanup(libzimg install)
