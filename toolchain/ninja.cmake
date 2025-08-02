ExternalProject_Add(ninja
    DEPENDS
        mimalloc-host
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/ninja-build/ninja.git
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG master
    CONFIGURE_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_FIND_NO_INSTALL_PREFIX=ON
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_ASM_COMPILER=clang
        -DCMAKE_C_COMPILER_WORKS=ON
        -DCMAKE_CXX_COMPILER_WORKS=ON
        -DCMAKE_ASM_COMPILER_WORKS=ON
        -DCMAKE_INTERPROCEDURAL_OPTIMIZATION_RELEASE=OFF
        -DBUILD_TESTING=OFF
        "-DCMAKE_C_FLAGS='${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_CXX_FLAGS='${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_ASM_FLAGS='${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_EXE_LINKER_FLAGS='${CMAKE_INSTALL_PREFIX}/lib/mimalloc.o -Wl,-s ${tc_ldflags}'"
    BUILD_COMMAND ${EXEC_HOST} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ninja)
cleanup(ninja install)
