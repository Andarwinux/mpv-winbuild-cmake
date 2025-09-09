ExternalProject_Add(svtav1-psy
    GIT_REPOSITORY https://github.com/BlueSwordM/svt-av1-psyex.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !test !Docs"
    GIT_REMOTE_NAME origin
    GIT_TAG master
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
        -DBUILD_APPS=ON
        -DC_FLAG_mno_avx=OFF
        -DCXX_FLAG_mno_avx=OFF
        "-DCMAKE_C_FLAGS='-mno-stack-arg-probe'"
        "-DCMAKE_CXX_FLAGS='-mno-stack-arg-probe'"
        "-DCMAKE_EXE_LINKER_FLAGS='-Xlinker --stack=1048576,1048576'"
        -DCMAKE_OUTPUT_DIRECTORY=<BINARY_DIR>
    ${novzeroupper} <SOURCE_DIR>/Source/Lib/ASM_SSE2/x86inc.asm
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/SvtAv1EncApp.exe ${MINGW_INSTALL_PREFIX}/bin/SvtAv1EncApp-PSY.exe
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(svtav1-psy)
cleanup(svtav1-psy install)
