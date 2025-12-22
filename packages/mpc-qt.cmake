ExternalProject_Add(mpc-qt
    DEPENDS
        mpv
        qt6-qtbase
        qt6-qtsvg
        qt6-qttools
    GIT_REPOSITORY https://github.com/mpc-qt/mpc-qt.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG master
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        ${qt_target_features}
        ${qt_force_skip_check}
        -DMPCQT_VERSION=100
        -DCMAKE_DISABLE_FIND_PACKAGE_Boost=OFF
        -DCMAKE_PREFIX_PATH=${MINGW_INSTALL_PREFIX}/qt6
        -DQT_HOST_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=<BINARY_DIR>
        "-DCMAKE_CXX_FLAGS='-lrpcrt4 -lusp10 -lbz2 -lbrotlicommon -lbrotlidec -lbrotlienc -lzstd -lpathcch -lshcore -Wl,-delayload=VSScript.dll -Wl,-delayload=VapourSynth.dll'"
    COMMAND ${CMAKE_COMMAND} -E copy ${mpv_src}/etc/mpv-icon.ico <BINARY_DIR>/mpc-qt.ico
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
        _FULL_DEBUGINFO=set:1
        _PDB_GENERATE=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpc-qt.exe ${MINGW_INSTALL_PREFIX}/bin/mpc-qt.exe
            COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpc-qt.pdb ${MINGW_INSTALL_PREFIX}/bin/mpc-qt.pdb
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mpc-qt)
cleanup(mpc-qt install)
