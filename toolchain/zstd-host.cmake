ExternalProject_Add(zstd-host
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/facebook/zstd.git
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !doc !contrib"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG dev
    CONFIGURE_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} -H<SOURCE_DIR>/build/cmake -B<BINARY_DIR>
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_FIND_NO_INSTALL_PREFIX=ON
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_ASM_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_C_COMPILER_WORKS=ON
        -DCMAKE_CXX_COMPILER_WORKS=ON
        -DCMAKE_ASM_COMPILER_WORKS=ON
        -DZSTD_BUILD_CONTRIB=OFF
        -DZSTD_BUILD_TESTS=OFF
        -DZSTD_LEGACY_SUPPORT=OFF
        -DZSTD_BUILD_PROGRAMS=OFF
        -DZSTD_BUILD_SHARED=OFF
        -DZSTD_BUILD_STATIC=ON
        -DZSTD_MULTITHREAD_SUPPORT=ON
        "-DCMAKE_REQUIRED_FLAGS='-O0 -fno-lto -fno-whole-program-vtables'"
        "-DCMAKE_REQUIRED_LINK_OPTIONS='-Wl,-O0,--lto-O0,--lto-CGO0,--no-gc-sections,--icf=none,--no-lto-whole-program-visibility,-mllvm,-polly=false'"
        "-DCMAKE_C_FLAGS='${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_CXX_FLAGS='${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_ASM_FLAGS='${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
    BUILD_COMMAND ${EXEC_HOST} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(zstd-host)
cleanup(zstd-host install)
