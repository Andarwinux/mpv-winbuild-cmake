ExternalProject_Add(ccache
    DEPENDS
        zstd-host
        mimalloc-host
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/ccache/ccache.git
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
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_ASM_COMPILER=${CMAKE_C_COMPILER}
        -DENABLE_TESTING=OFF
        -DSTATIC_LINK=OFF
        -DZSTD_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
        -DZSTD_LIBRARY=${CMAKE_INSTALL_PREFIX}/lib/libzstd.a
        -DHIREDIS_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
        -DHIREDIS_LIBRARY=${CMAKE_INSTALL_PREFIX}/lib/libhiredis.a
        -DUSE_XXH_DISPATCH=ON
        -DENABLE_DOCUMENTATION=OFF
        -DWARNINGS_AS_ERRORS=OFF
        -DCCACHE_DEV_MODE=OFF
        -DDEPS=LOCAL
        -DDEP_XXHASH=DOWNLOAD
        -DDEP_FMT=BUNDLED
        -DDEP_BLAKE3=BUNDLED
        -DREDIS_STORAGE_BACKEND=OFF
        -DHTTP_STORAGE_BACKEND=OFF
        -DHAVE_ASM_SSE2=OFF
        -DHAVE_ASM_SSE41=OFF
        -DHAVE_C_SSE2=OFF
        -DHAVE_C_SSE41=OFF
        "-DCMAKE_REQUIRED_FLAGS='-O0 -fno-lto -fno-whole-program-vtables'"
        "-DCMAKE_REQUIRED_LINK_OPTIONS='-Wl,-O0,--lto-O0,--lto-CGO0,--no-gc-sections,--icf=none,--no-lto-whole-program-visibility,-mllvm,-polly=false'"
        "-DCMAKE_C_FLAGS='-DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 -DXXH_ENABLE_AUTOVECTORIZE ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_CXX_FLAGS='-DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 -DXXH_ENABLE_AUTOVECTORIZE -include stdlib.h ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_ASM_FLAGS='-DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 -DXXH_ENABLE_AUTOVECTORIZE ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_EXE_LINKER_FLAGS='${CMAKE_INSTALL_PREFIX}/lib/mimalloc.o ${tc_ldflags}'"
    BUILD_COMMAND ${EXEC_HOST} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ccache)
cleanup(ccache install)
