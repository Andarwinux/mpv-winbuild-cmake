ExternalProject_Add(directx-headers
    GIT_REPOSITORY https://github.com/microsoft/DirectX-Headers.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone include/directx"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/include/directx/d3d12.h          ${MINGW_INSTALL_PREFIX}/include/d3d12.h
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/include/directx/d3d12video.h     ${MINGW_INSTALL_PREFIX}/include/d3d12video.h
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/include/directx/d3d12shader.h    ${MINGW_INSTALL_PREFIX}/include/d3d12shader.h
    COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/include/directx/d3d12sdklayers.h ${MINGW_INSTALL_PREFIX}/include/d3d12sdklayers.h
    LOG_DOWNLOAD 1 LOG_UPDATE 1
)

force_rebuild_git(directx-headers)
cleanup(directx-headers install)
