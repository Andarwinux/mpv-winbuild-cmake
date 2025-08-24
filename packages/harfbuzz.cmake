ExternalProject_Add(harfbuzz
    DEPENDS
        freetype2
        libpng
    GIT_REPOSITORY https://github.com/harfbuzz/harfbuzz.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !test"
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${harfbuzz_force_skip_check}
        -DHB_HAVE_FREETYPE=ON
        -DHB_HAVE_GDI=ON
        -DHB_HAVE_DIRECTWRITE=ON
        -DHB_HAVE_UNISCRIBE=ON
        -DHB_BUILD_SUBSET=OFF
        "-DCMAKE_C_FLAGS='-DHB_NO_LEGACY -DHB_NO_PRAGMA_GCC_DIAGNOSTIC_ERROR'"
        "-DCMAKE_CXX_FLAGS='-DHB_NO_LEGACY -DHB_NO_PRAGMA_GCC_DIAGNOSTIC_ERROR'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FULL_DEBUGINFO=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(harfbuzz)
cleanup(harfbuzz install)
