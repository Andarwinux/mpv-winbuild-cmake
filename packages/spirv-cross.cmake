ExternalProject_Add(spirv-cross
    GIT_REPOSITORY https://github.com/KhronosGroup/SPIRV-Cross.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !reference !shaders*"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG main
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DSPIRV_CROSS_SHARED=OFF
        -DSPIRV_CROSS_CLI=OFF
        -DSPIRV_CROSS_ENABLE_MSL=OFF
        -DSPIRV_CROSS_ENABLE_CPP=OFF
        -DSPIRV_CROSS_ENABLE_REFLECT=OFF
        -DSPIRV_CROSS_ENABLE_UTIL=OFF
        -DSPIRV_CROSS_ENABLE_TESTS=OFF
        -DSPIRV_CROSS_EXCEPTIONS_TO_ASSERTIONS=ON
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
          COMMAND bash -c "cd <BINARY_DIR> && echo -e 'create libspirv-cross-c-shared.a\naddlib libspirv-cross-c.a\naddlib libspirv-cross-core.a\naddlib libspirv-cross-glsl.a\naddlib libspirv-cross-hlsl.a\nsave\nend' | ${EXEC} ${TARGET_ARCH}-ar -M"
          COMMAND ${EXEC} ${CMAKE_COMMAND} -E copy <BINARY_DIR>/libspirv-cross-c-shared.a <BINARY_DIR>/libspirv-cross-c.a
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
            COMMAND ${CMAKE_COMMAND} -E create_symlink ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/spirv-cross-c.pc ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/spirv-cross-c-shared.pc
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(spirv-cross)
cleanup(spirv-cross install)
