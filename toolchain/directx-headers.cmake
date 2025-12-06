ExternalProject_Add(directx-headers
    DEPENDS
        mingw-w64-headers
    GIT_REPOSITORY https://github.com/microsoft/DirectX-Headers.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone include/directx/d3d12video.h"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/include/directx/d3d12video.h ${MINGW_INSTALL_PREFIX}/include/d3d12video.h
    LOG_DOWNLOAD 1 LOG_UPDATE 1
)

force_rebuild_git(directx-headers)
cleanup(directx-headers install)
