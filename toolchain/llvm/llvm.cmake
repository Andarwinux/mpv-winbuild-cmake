ExternalProject_Add(llvm
    DEPENDS
        mimalloc-host
        libxml2-host
        zlib-host
        zstd-host
    GIT_REPOSITORY https://github.com/llvm/llvm-project.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !*/test !*/docs !*/unittests !*/examples !*/benchmarks !/lldb !/mlir !/clang-tools-extra !/mlir !/flang !openmp !libclc !bolt !cross-project-tests !offload !llvm-libgcc !third-party lld/docs/CMakeLists.txt clang/examples/CMakeLists.txt polly/test/CMakeLists.txt polly/docs/CMakeLists.txt polly/unittests/CMakeLists.txt"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG main
    LIST_SEPARATOR ^^
    CONFIGURE_COMMAND ${EXEC} echo > <SOURCE_DIR>/polly/docs/CMakeLists.txt && echo > <SOURCE_DIR>/polly/test/CMakeLists.txt && echo > <SOURCE_DIR>/polly/unittests/CMakeLists.txt && CONF=1 PKG_CONFIG_LIBDIR= ${CMAKE_COMMAND} -H<SOURCE_DIR>/llvm -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_FIND_NO_INSTALL_PREFIX=OFF
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -DCMAKE_INSTALL_BINDIR=llvmbin
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_BUILD_WITH_INSTALL_RPATH=OFF
        -DCMAKE_INSTALL_RPATH=OFF
        -DCMAKE_SKIP_RPATH=ON
        -DLLVM_INSTALL_TOOLCHAIN_ONLY=ON
        -DLLVM_TARGETS_TO_BUILD='AArch64^^X86^^NVPTX'
        -DLLVM_ENABLE_PROJECTS='clang^^lld^^polly'
        -DLLVM_POLLY_LINK_INTO_TOOLS=ON
        -DLLVM_ENABLE_ASSERTIONS=OFF
        -DLLVM_ENABLE_LIBCXX=ON
        -DLLVM_ENABLE_LLD=ON
        -DLLVM_ENABLE_PIC=OFF
        -DLLVM_ENABLE_UNWIND_TABLES=OFF
        -DLLVM_ENABLE_LTO=${LLVM_ENABLE_LTO}
        -DCLANG_ENABLE_ARCMT=OFF
        -DCLANG_ENABLE_STATIC_ANALYZER=OFF
        -DLLVM_INCLUDE_TESTS=OFF
        -DLLVM_INCLUDE_EXAMPLES=OFF
        -DLLVM_INCLUDE_DOCS=OFF
        -DCLANG_INCLUDE_DOCS=OFF
        -DLLVM_INCLUDE_UTILS=OFF
        -DLLVM_INCLUDE_RUNTIMES=OFF
        -DLLVM_BUILD_RUNTIME=OFF
        -DLLVM_BUILD_RUNTIMES=OFF
        -DLLVM_INCLUDE_BENCHMARKS=OFF
        -DCLANG_DEFAULT_RTLIB=compiler-rt
        -DCLANG_DEFAULT_UNWINDLIB=libunwind
        -DCLANG_DEFAULT_CXX_STDLIB=libc++
        -DCLANG_DEFAULT_LINKER=lld
        -DCLANG_DEFAULT_OBJCOPY=llvm-objcopy
        -DCLANG_CONFIG_FILE_SYSTEM_DIR='../etc'
        -DLLD_DEFAULT_LD_LLD_IS_MINGW=OFF
        -DLLVM_LINK_LLVM_DYLIB=OFF
        -DLLVM_BUILD_LLVM_DYLIB=OFF
        -DBUILD_SHARED_LIBS=OFF
        -DCLANG_BUILD_TOOLS=OFF
        -DCLANG_ENABLE_OBJC_REWRITER=OFF
        -DCLANG_TOOL_AMDGPU_ARCH_BUILD=OFF
        -DCLANG_TOOL_APINOTES_TEST_BUILD=OFF
        -DCLANG_TOOL_ARCMT_TEST_BUILD=OFF
        -DCLANG_TOOL_C_ARCMT_TEST_BUILD=OFF
        -DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF
        -DCLANG_TOOL_CLANG_CHECK_BUILD=OFF
        -DCLANG_TOOL_CLANG_DIFF_BUILD=OFF
        -DCLANG_TOOL_CLANG_EXTDEF_MAPPING_BUILD=OFF
        -DCLANG_TOOL_CLANG_FORMAT_BUILD=OFF
        -DCLANG_TOOL_CLANG_FORMAT_VS_BUILD=OFF
        -DCLANG_TOOL_CLANG_FUZZER_BUILD=OFF
        -DCLANG_TOOL_CLANG_IMPORT_TEST_BUILD=OFF
        -DCLANG_TOOL_CLANG_INSTALLAPI_BUILD=OFF
        -DCLANG_TOOL_CLANG_LINKER_WRAPPER_BUILD=OFF
        -DCLANG_TOOL_CLANG_NVLINK_WRAPPER_BUILD=OFF
        -DCLANG_TOOL_CLANG_OFFLOAD_BUNDLER_BUILD=OFF
        -DCLANG_TOOL_CLANG_OFFLOAD_PACKAGER_BUILD=OFF
        -DCLANG_TOOL_CLANG_REFACTOR_BUILD=OFF
        -DCLANG_TOOL_CLANG_RENAME_BUILD=OFF
        -DCLANG_TOOL_CLANG_REPL_BUILD=OFF
        -DCLANG_TOOL_CLANG_SCAN_DEPS_BUILD=OFF
        -DCLANG_TOOL_CLANG_SHLIB_BUILD=OFF
        -DCLANG_TOOL_CLANG_SYCL_LINKER_BUILD=OFF
        -DCLANG_TOOL_DIAGTOOL_BUILD=OFF
        -DCLANG_TOOL_LIBCLANG_BUILD=OFF
        -DCLANG_TOOL_NVPTX_ARCH_BUILD=OFF
        -DCLANG_TOOL_SCAN_BUILD_BUILD=OFF
        -DCLANG_TOOL_SCAN_BUILD_PY_BUILD=OFF
        -DCLANG_TOOL_SCAN_VIEW_BUILD=OFF
        -DLLVM_BUILD_TELEMETRY=OFF
        -DLLVM_BUILD_UTILS=OFF
        -DLLVM_ENABLE_BINDINGS=OFF
        -DLLVM_ENABLE_LIBEDIT=OFF
        -DLLVM_ENABLE_LIBPFM=OFF
        -DLLVM_ENABLE_OCAMLDOC=OFF
        -DLLVM_TOOL_BUGPOINT_BUILD=OFF
        -DLLVM_TOOL_BUGPOINT_PASSES_BUILD=OFF
        -DLLVM_TOOL_DSYMUTIL_BUILD=OFF
        -DLLVM_TOOL_DXIL_DIS_BUILD=OFF
        -DLLVM_TOOL_GOLD_BUILD=OFF
        -DLLVM_TOOL_LLC_BUILD=OFF
        -DLLVM_TOOL_LLI_BUILD=OFF
        -DLLVM_TOOL_LLVM_AS_BUILD=OFF
        -DLLVM_TOOL_LLVM_AS_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_BCANALYZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_C_TEST_BUILD=OFF
        -DLLVM_TOOL_LLVM_CAT_BUILD=OFF
        -DLLVM_TOOL_LLVM_CFI_VERIFY_BUILD=OFF
        -DLLVM_TOOL_LLVM_CGDATA_BUILD=OFF
        -DLLVM_TOOL_LLVM_CONFIG_BUILD=OFF
        -DLLVM_TOOL_LLVM_COV_BUILD=OFF
        -DLLVM_TOOL_LLVM_CTXPROF_UTIL_BUILD=OFF
        -DLLVM_TOOL_LLVM_CVTRES_BUILD=OFF
        -DLLVM_TOOL_LLVM_CXXDUMP_BUILD=OFF
        -DLLVM_TOOL_LLVM_CXXFILT_BUILD=OFF
        -DLLVM_TOOL_LLVM_CXXMAP_BUILD=OFF
        -DLLVM_TOOL_LLVM_DEBUGINFO_ANALYZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_DEBUGINFOD_BUILD=OFF
        -DLLVM_TOOL_LLVM_DEBUGINFOD_FIND_BUILD=OFF
        -DLLVM_TOOL_LLVM_DIFF_BUILD=OFF
        -DLLVM_TOOL_LLVM_DIS_BUILD=OFF
        -DLLVM_TOOL_LLVM_DIS_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_DLANG_DEMANGLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_DRIVER_BUILD=ON
        -DLLVM_TOOL_LLVM_DWARFDUMP_BUILD=OFF
        -DLLVM_TOOL_LLVM_DWARFUTIL_BUILD=OFF
        -DLLVM_TOOL_LLVM_DWP_BUILD=OFF
        -DLLVM_TOOL_LLVM_EXEGESIS_BUILD=OFF
        -DLLVM_TOOL_LLVM_EXTRACT_BUILD=OFF
        -DLLVM_TOOL_LLVM_GSYMUTIL_BUILD=OFF
        -DLLVM_TOOL_LLVM_IFS_BUILD=OFF
        -DLLVM_TOOL_LLVM_ISEL_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_ITANIUM_DEMANGLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_JITLINK_BUILD=OFF
        -DLLVM_TOOL_LLVM_JITLISTENER_BUILD=OFF
        -DLLVM_TOOL_LLVM_LIBTOOL_DARWIN_BUILD=OFF
        -DLLVM_TOOL_LLVM_LINK_BUILD=OFF
        -DLLVM_TOOL_LLVM_LIPO_BUILD=OFF
        -DLLVM_TOOL_LLVM_LTO_BUILD=OFF
        -DLLVM_TOOL_LLVM_LTO2_BUILD=OFF
        -DLLVM_TOOL_LLVM_MC_ASSEMBLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_MC_BUILD=OFF
        -DLLVM_TOOL_LLVM_MC_DISASSEMBLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_MCA_BUILD=OFF
        -DLLVM_TOOL_LLVM_MICROSOFT_DEMANGLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_MODEXTRACT_BUILD=OFF
        -DLLVM_TOOL_LLVM_OPT_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_OPT_REPORT_BUILD=OFF
        -DLLVM_TOOL_LLVM_PDBUTIL_BUILD=OFF
        -DLLVM_TOOL_LLVM_PROFGEN_BUILD=OFF
        -DLLVM_TOOL_LLVM_READTAPI_BUILD=OFF
        -DLLVM_TOOL_LLVM_REDUCE_BUILD=OFF
        -DLLVM_TOOL_LLVM_REMARKUTIL_BUILD=OFF
        -DLLVM_TOOL_LLVM_RTDYLD_BUILD=OFF
        -DLLVM_TOOL_LLVM_RUST_DEMANGLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_SHLIB_BUILD=OFF
        -DLLVM_TOOL_LLVM_SIM_BUILD=OFF
        -DLLVM_TOOL_LLVM_SPECIAL_CASE_LIST_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_SPLIT_BUILD=OFF
        -DLLVM_TOOL_LLVM_STRESS_BUILD=OFF
        -DLLVM_TOOL_LLVM_STRINGS_BUILD=OFF
        -DLLVM_TOOL_LLVM_TLI_CHECKER_BUILD=OFF
        -DLLVM_TOOL_LLVM_UNDNAME_BUILD=OFF
        -DLLVM_TOOL_LLVM_XRAY_BUILD=OFF
        -DLLVM_TOOL_LLVM_YAML_NUMERIC_PARSER_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LLVM_YAML_PARSER_FUZZER_BUILD=OFF
        -DLLVM_TOOL_LTO_BUILD=OFF
        -DLLVM_TOOL_OBJ2YAML_BUILD=OFF
        -DLLVM_TOOL_OPT_BUILD=OFF
        -DLLVM_TOOL_OPT_VIEWER_BUILD=OFF
        -DLLVM_TOOL_REDUCE_CHUNK_LIST_BUILD=OFF
        -DLLVM_TOOL_REMARKS_SHLIB_BUILD=OFF
        -DLLVM_TOOL_SANCOV_BUILD=OFF
        -DLLVM_TOOL_SANSTATS_BUILD=OFF
        -DLLVM_TOOL_SPIRV_TOOLS_BUILD=OFF
        -DLLVM_TOOL_VERIFY_USELISTORDER_BUILD=OFF
        -DLLVM_TOOL_VFABI_DEMANGLE_FUZZER_BUILD=OFF
        -DLLVM_TOOL_XCODE_TOOLCHAIN_BUILD=OFF
        -DLLVM_TOOL_YAML2OBJ_BUILD=OFF
        -DLLVM_ENABLE_ZLIB=FORCE_ON
        -DZLIB_LIBRARY=${CMAKE_INSTALL_PREFIX}/lib/libz.a
        -DZLIB_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
        -DLLVM_ENABLE_ZSTD=FORCE_ON
        -DLLVM_USE_STATIC_ZSTD=ON
        -Dzstd_LIBRARY=${CMAKE_INSTALL_PREFIX}/lib/libzstd.a
        -Dzstd_INCLUDE_DIR=${CMAKE_INSTALL_PREFIX}/include
        -DLLVM_ENABLE_LIBXML2=FORCE_ON
        -DLIBXML2_LIBRARIES=${CMAKE_INSTALL_PREFIX}/lib/libxml2.a
        -DLIBXML2_INCLUDE_DIRS=${CMAKE_INSTALL_PREFIX}/include/libxml2
        -DHAVE_LIBXML2=ON
        "-DLLVM_THINLTO_CACHE_PATH='${CMAKE_INSTALL_PREFIX}/llvm-thinlto'"
        "-DCMAKE_C_FLAGS='-DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_CXX_FLAGS='-DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_ASM_FLAGS='-DBLAKE3_NO_SSE2 -DBLAKE3_NO_SSE41 ${tc_cflags} ${tc_libcxx} ${tc_compiler_rt} ${llvm_pgo}'"
        "-DCMAKE_EXE_LINKER_FLAGS='${CMAKE_INSTALL_PREFIX}/lib/mimalloc.o -Wl,-q,--thinlto-cache-policy=cache_size_bytes=4g:prune_interval=1m ${tc_ldflags}'"
        -DLLVM_TOOLCHAIN_TOOLS='llvm-driver^^llvm-ar^^llvm-ranlib^^llvm-objdump^^llvm-rc^^llvm-nm^^llvm-readobj^^llvm-dlltool^^llvm-objcopy^^llvm-strip^^llvm-profdata^^llvm-addr2line^^llvm-symbolizer^^llvm-windres^^llvm-ml^^llvm-mt^^llvm-readelf^^llvm-size'
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR> llvm-driver
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install-llvm-driver install-clang-resource-headers
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add(llvm-bolt
    URL https://www.sqlite.org/2024/sqlite-autoconf-3470200.tar.gz
    URL_HASH SHA3_256=52cd4a2304b627abbabe1a438ba853d0f6edb8e2774fcb5773c7af11077afe94
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${EXEC} llvm-bolt
        ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm
        -o ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr
        --instrument
        --instrumentation-file-append-pid
        --instrumentation-file=${CMAKE_INSTALL_PREFIX}/llvm-bolt/llvm
        --lite=false
    COMMAND ${EXEC} ln -s ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr ld.lld
    COMMAND ${EXEC} mkdir -p ${CMAKE_INSTALL_PREFIX}/llvm-bolt
    COMMAND ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang --target=${TARGET_CPU}-pc-windows-gnu --sysroot=${MINGW_INSTALL_PREFIX} -D_WIN32_WINNT=0x0A00 -DWINVER=0x0A00 -DNDEBUG -D__CRT__NO_INLINE -Xclang -mlong-double-64 -flto=thin -fwhole-program-vtables -fno-split-lto-unit -fuse-ld=lld --ld-path=$PWD/ld.lld -O3 -fno-auto-import -fdata-sections -ffunction-sections -funroll-loops -fstrict-flex-arrays=3 -falign-functions=32 -fno-signed-zeros -fno-trapping-math -ffp-contract=fast -fno-math-errno -fomit-frame-pointer -fmerge-all-constants -fno-unique-section-names -gcodeview -mguard=cf -Wl,-mllvm,-slp-revec ${llvm_mllvm_lto} ${polly_lto} -g3 -Wl,--gc-sections,--icf=all,-O3,--lto-O3,--lto-CGO3,--disable-runtime-pseudo-reloc,--pdb= sqlite3.c shell.c -o sqlite3.exe
    COMMAND ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang --target=${TARGET_CPU}-pc-windows-gnu --sysroot=${MINGW_INSTALL_PREFIX} -D_WIN32_WINNT=0x0A00 -DWINVER=0x0A00 -DNDEBUG -D__CRT__NO_INLINE -Xclang -mlong-double-64 -fno-split-lto-unit -fuse-ld=lld --ld-path=$PWD/ld.lld -O3 -fno-auto-import -fdata-sections -ffunction-sections -funroll-loops -fstrict-flex-arrays=3 -falign-functions=32 -fno-signed-zeros -fno-trapping-math -ffp-contract=fast -fno-math-errno -fomit-frame-pointer -fmerge-all-constants -fno-unique-section-names -gcodeview -mguard=cf -mllvm -slp-revec ${llvm_mllvm} ${polly} -g3 -Wl,--gc-sections,--icf=all,-O3,--lto-O3,--lto-CGO3,--disable-runtime-pseudo-reloc,--pdb= sqlite3.c shell.c -o sqlite3.exe
    COMMAND ${EXEC} rm sqlite3.exe ld.lld ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr
    COMMAND ${EXEC} merge-fdata ${CMAKE_INSTALL_PREFIX}/llvm-bolt/* -o llvm.fdata
    COMMAND ${EXEC} rm -r ${CMAKE_INSTALL_PREFIX}/llvm-bolt
    COMMAND ${EXEC} llvm-bolt
        --data llvm.fdata
        ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm
        -o ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.bolt
        --align-blocks
        --assume-abi
        --cg-use-split-hot-size
        --cmov-conversion
        --dyno-stats
        --fix-block-counts
        --fix-func-counts
        --frame-opt-rm-stores
        --frame-opt=all
        --hot-data
        --hot-text
        --icf=all
        --icp-inline
        --icp-jump-tables-targets
        --icp=jump-tables
        --infer-fall-throughs
        --inline-ap
        --inline-small-functions
        --iterative-guess
        --jump-tables=aggressive
        --min-branch-clusters
        --peepholes=all
        --plt=all
        --reg-reassign
        --reorder-blocks=ext-tsp
        --reorder-functions=cdsort
        --sctc-mode=always
        --simplify-rodata-loads
        --split-all-cold
        --split-eh
        --split-functions
        --split-strategy=cdsplit
        --stoke
        --tail-duplication=cache
        --three-way-branch
    COMMAND ${EXEC} llvm-strip -s ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.bolt
    COMMAND ${EXEC} rm -r <SOURCE_DIR>/llvm.fdata
    INSTALL_COMMAND ${EXEC} mv ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.bolt ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(llvm-bolt install)

force_rebuild_git(llvm)
cleanup(llvm install)
get_property(LLVM_SRC TARGET llvm PROPERTY _EP_SOURCE_DIR)
