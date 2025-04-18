ExternalProject_Add(mimalloc-host
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_REPOSITORY https://github.com/Andarwinux/mimalloc.git
    GIT_REMOTE_NAME origin
    GIT_TAG dev2
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 PKG_CONFIG_LIBDIR= ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
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
        -DMI_USE_CXX=OFF
        -DMI_OVERRIDE=ON
        -DMI_INSTALL_TOPLEVEL=ON
        -DMI_BUILD_TESTS=OFF
        -DMI_BUILD_SHARED=OFF
        -DMI_BUILD_STATIC=OFF
        -DMI_SKIP_COLLECT_ON_EXIT=ON
        "-DCMAKE_C_FLAGS='-DMI_DEFAULT_ALLOW_LARGE_OS_PAGES=1 -DMI_DEFAULT_ARENA_EAGER_COMMIT=1 -DMI_DEBUG=0 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_CXX_FLAGS='-DMI_DEFAULT_ALLOW_LARGE_OS_PAGES=1 -DMI_DEFAULT_ARENA_EAGER_COMMIT=1 -DMI_DEBUG=0 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_ASM_FLAGS='-DMI_DEFAULT_ALLOW_LARGE_OS_PAGES=1 -DMI_DEFAULT_ARENA_EAGER_COMMIT=1 -DMI_DEBUG=0 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
    COMMAND ${EXEC} CONF=1 PKG_CONFIG_LIBDIR= ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>/shared
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
        -DMI_USE_CXX=OFF
        -DMI_OVERRIDE=ON
        -DMI_INSTALL_TOPLEVEL=ON
        -DMI_BUILD_TESTS=OFF
        -DMI_BUILD_SHARED=ON
        -DMI_BUILD_STATIC=OFF
        -DMI_BUILD_OBJECT=OFF
        -DMI_SKIP_COLLECT_ON_EXIT=ON
        -DMI_USE_LIBATOMIC=OFF
        -DCMAKE_PLATFORM_NO_VERSIONED_SONAME=ON
        "-DCMAKE_C_FLAGS='-DMI_DEFAULT_ALLOW_LARGE_OS_PAGES=1 -DMI_DEFAULT_ARENA_EAGER_COMMIT=1 -DMI_DEBUG=0 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo} -ftls-model=initial-exec --unwindlib=none'"
        "-DCMAKE_CXX_FLAGS='-DMI_DEFAULT_ALLOW_LARGE_OS_PAGES=1 -DMI_DEFAULT_ARENA_EAGER_COMMIT=1 -DMI_DEBUG=0 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo} -ftls-model=initial-exec --unwindlib=none'"
        "-DCMAKE_ASM_FLAGS='-DMI_DEFAULT_ALLOW_LARGE_OS_PAGES=1 -DMI_DEFAULT_ARENA_EAGER_COMMIT=1 -DMI_DEBUG=0 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo} -ftls-model=initial-exec --unwindlib=none'"
        "-DCMAKE_SHARED_LINKER_FLAGS='-Wl,-s ${tc_ldflags}'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
          COMMAND ${EXEC} ninja -C <BINARY_DIR>/shared
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
            COMMAND ${EXEC} ${CMAKE_COMMAND} -E copy <BINARY_DIR>/shared/libmimalloc.so ${CMAKE_INSTALL_PREFIX}/bin/libmimalloc.so
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mimalloc-host)
cleanup(mimalloc-host install)
