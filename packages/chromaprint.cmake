ExternalProject_Add(chromaprint
    GIT_REPOSITORY https://github.com/acoustid/chromaprint.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_TOOLS=OFF
        -DBUILD_TESTS=OFF
        -DKISSFFT_STATIC=ON
        -DKISSFFT_TOOLS=OFF
        -DKISSFFT_TEST=OFF
        -DKISSFFT_DATATYPE=simd
        -DFFT_LIB=kissfft
        -DFFMPEG_LIBRARIES=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_FFmpeg=ON
        -DKISSFFT_SOURCE_DIR=<SOURCE_DIR>/src/3rdparty/kissfft
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_REASSOC_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
          COMMAND bash -c "echo 'Cflags.private: -DCHROMAPRINT_NODLL' >> <BINARY_DIR>/libchromaprint.pc"
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(chromaprint)
cleanup(chromaprint install)
