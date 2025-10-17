ExternalProject_Add(svtav1
    GIT_REPOSITORY https://gitlab.com/AOMediaCodec/SVT-AV1.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !test !Docs"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${svtav1_force_skip_check}
        -DENABLE_AVX512=ON
        -DBUILD_ENC=ON
        -DSVT_AV1_LTO=OFF
        -DBUILD_APPS=OFF
        -DC_FLAG_mno_avx=OFF
        -DCXX_FLAG_mno_avx=OFF
        -DCMAKE_OUTPUT_DIRECTORY=<BINARY_DIR>
    ${novzeroupper} <SOURCE_DIR>/Source/Lib/ASM_SSE2/x86inc.asm
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _NO_AUTO_VAR_INIT_ZERO=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(svtav1)
cleanup(svtav1 install)
