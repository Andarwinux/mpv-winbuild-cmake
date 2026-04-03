ExternalProject_Add(ggml
    DEPENDS
        vulkan
    GIT_REPOSITORY https://github.com/ggml-org/ggml.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !examples"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} sed -i [['/CMAKE_STATIC_LIBRARY_PREFIX /d']] <SOURCE_DIR>/CMakeLists.txt
    COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DGGML_CCACHE=OFF
        -DGGML_ALL_WARNINGS=OFF
        -DGGML_VULKAN=ON
        -DGGML_OPENMP=OFF
        -DGGML_BUILD_TESTS=OFF
        -DGGML_BUILD_EXAMPLES=OFF
        -DGGML_STANDALONE=ON
        -DHOST_C_COMPILER=${CMAKE_C_COMPILER}
        -DHOST_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ggml)
cleanup(ggml install)
