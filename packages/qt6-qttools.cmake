ExternalProject_Add(qt6-qttools
    DEPENDS
        qt6-qtbase
    GIT_REPOSITORY https://github.com/qt/qttools.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !examples"
    GIT_REMOTE_NAME origin
    GIT_TAG dev
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC_HOST} echo '' > <SOURCE_DIR>/src/linguist/lcheck/CMakeLists.txt
    COMMAND ${EXEC_HOST} echo '' > <SOURCE_DIR>/src/linguist/lprodump/CMakeLists.txt
    COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${qthost_force_skip_check}
        -GNinja
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DBUILD_WITH_PCH=ON
        -DINPUT_opengl=no
        -DQT_BUILD_BENCHMARKS=OFF
        -DQT_BUILD_DOCS=OFF
        -DQT_BUILD_EXAMPLES_BY_DEFAULT=OFF
        -DQT_BUILD_EXAMPLES=OFF
        -DQT_BUILD_TESTS_BY_DEFAULT=OFF
        -DQT_BUILD_TESTS=OFF
        -DQT_FEATURE_accessibility=OFF
        -DQT_FEATURE_assistant=OFF
        -DQT_FEATURE_backtrace=OFF
        -DQT_FEATURE_clang-rtti=OFF
        -DQT_FEATURE_clang=OFF
        -DQT_FEATURE_clangcpp=OFF
        -DQT_FEATURE_designer=OFF
        -DQT_FEATURE_distancefieldgenerator=OFF
        -DQT_FEATURE_egl=OFF
        -DQT_FEATURE_glib=OFF
        -DQT_FEATURE_glibc_fortify_source=OFF
        -DQT_FEATURE_gssapi=OFF
        -DQT_FEATURE_gui=OFF
        -DQT_FEATURE_icu=OFF
        -DQT_FEATURE_intelcet=OFF
        -DQT_FEATURE_kmap2qmap=OFF
        -DQT_FEATURE_libcpp_hardening=OFF
        -DQT_FEATURE_library=OFF
        -DQT_FEATURE_liburing=OFF
        -DQT_FEATURE_linguist=ON
        -DQT_FEATURE_network=OFF
        -DQT_FEATURE_opengl_desktop=OFF
        -DQT_FEATURE_opengl_dynamic=OFF
        -DQT_FEATURE_opengl=OFF
        -DQT_FEATURE_opengles2=OFF
        -DQT_FEATURE_openssl=OFF
        -DQT_FEATURE_pixeltool=OFF
        -DQT_FEATURE_qdbus=OFF
        -DQT_FEATURE_qdoc=OFF
        -DQT_FEATURE_qev=OFF
        -DQT_FEATURE_qmake=OFF
        -DQT_FEATURE_qtattributionsscanner=OFF
        -DQT_FEATURE_qtdiag=OFF
        -DQT_FEATURE_qtplugininfo=OFF
        -DQT_FEATURE_sql=OFF
        -DQT_FEATURE_stack_protector=OFF
        -DQT_FEATURE_testlib=OFF
        -DQT_FEATURE_trivial_auto_var_init_pattern=OFF
        -DQT_FEATURE_wasmdeployqt=OFF
        -DQT_FEATURE_xcb_xlib=OFF
        -DQT_FEATURE_xcb=OFF
        -DQT_FEATURE_xkbcommon=OFF
        -DQT_FEATURE_xml=OFF
        -DQT_FEATURE_zstd=OFF
        -DQT_INSTALL_EXAMPLES_SOURCES_BY_DEFAULT=OFF
        -DQT_UNITY_BUILD=ON
        -DQT_USE_CCACHE=OFF
        -DCMAKE_MESSAGE_LOG_LEVEL=STATUS
        -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_FIND_ROOT_PATH=${CMAKE_INSTALL_PREFIX}/qt6
        -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY
        "-DCMAKE_REQUIRED_FLAGS='-O0'"
        "-DCMAKE_REQUIRED_LINK_OPTIONS='-Wl,-O0,--icf=none,--no-gc-sections'"
        "-DCMAKE_C_FLAGS='-Wno-unused-command-line-argument -w -g0 -fno-ident -fno-temp-file -fno-plt -Wa,--crel,--allow-experimental-crel -march=native -O3 -fdata-sections -ffunction-sections -fseparate-named-sections -fno-unique-section-names -fno-semantic-interposition -fvisibility=hidden -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec -Xclang -fno-pch-timestamp'"
        "-DCMAKE_CXX_FLAGS='-Wno-unused-command-line-argument -w -g0 -fno-ident -fno-temp-file -fno-plt -Wa,--crel,--allow-experimental-crel -march=native -O3 -fdata-sections -ffunction-sections -fseparate-named-sections -fno-unique-section-names -fno-semantic-interposition -fvisibility=hidden -fno-math-errno -fno-signed-zeros -fno-trapping-math -falign-functions=32 -ffp-contract=fast -ftls-model=local-exec -Xclang -fno-pch-timestamp'"
        "-DCMAKE_EXE_LINKER_FLAGS='-fuse-ld=lld -Wl,-Bsymbolic,--build-id=none,-s,-O3,--icf=all,--gc-sections,-zpack-relative-relocs,-zcommon-page-size=2097152,-zmax-page-size=2097152,-zseparate-loadable-segments'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(qt6-qttools)
cleanup(qt6-qttools install)
