ExternalProject_Add(libsdl2
    DEPENDS
        vulkan
        libiconv
        libsamplerate
    GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !test"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG SDL2
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${libsdl2_force_skip_check}
        -DSDL_VULKAN=ON
        -DSDL_LIBICONV=ON
        -DSDL_SYSTEM_ICONV=ON
        -DSDL_LIBSAMPLERATE=ON
        -DSDL_LIBSAMPLERATE_SHARED=OFF
        -DSDL_MMX=OFF
        -DSDL_SSE=OFF
        -DSDL_SSE2=OFF
        -DSDL_SSE3=OFF
        -DSDL_CCACHE=OFF
        -DSDL_TEST=OFF
        -DSDL_TEST_LIBRARY=OFF
        -DSDL_ASSERTIONS=0
        -DSDL2_DISABLE_SDL2MAIN=ON
        -DSDL_ASSEMBLY=OFF
        -DSDL_OPENGL=OFF
        -DSDL_OPENGLES=OFF
        -DHAVE_GDWARF_4=OFF
        -DHAVE_GCC_NO_STRICT_ALIASING=OFF
        "-DCMAKE_C_FLAGS='-U__MMX__ -DSDL_CPUINFO_DISABLED'"
        "-DCMAKE_CXX_FLAGS='-U__MMX__ -DSDL_CPUINFO_DISABLED'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    COMMAND ${EXEC} sed -i [['s/-lSDL2/-lSDL2 -lsamplerate/']] ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/sdl2.pc
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libsdl2)
cleanup(libsdl2 install)
