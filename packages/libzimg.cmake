get_property(src_graphengine TARGET graphengine PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(libzimg
    DEPENDS
        graphengine
    GIT_REPOSITORY https://bitbucket.org/the-sekrit-twc/zimg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    PATCH_COMMAND ${EXEC} sed -i "s/Windows.h/windows.h/g" src/zimg/common/arm/cpuinfo_arm.cpp
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${CMAKE_COMMAND} -E remove_directory graphengine
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${src_graphengine} graphengine
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
    BUILD_COMMAND ${MAKE} EXCEP=1
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libzimg)
cleanup(libzimg install)
