set(bolt_training_common_args
    ${ARCH_FLAGS} ${ARCH_FLAGS_FORCE} ${OPT_FLAGS} --target=${TARGET_CPU}-pc-windows-gnu --sysroot=${MINGW_INSTALL_PREFIX} -Xclang -mlong-double-64 -fno-temp-file -fsplit-lto-unit -fuse-ld=lld --ld-path=$PWD/ld.lld -O3 -fno-auto-import -fdata-sections -ffunction-sections -ffast-math -gcodeview -mguard=cf -w -g3 -Wl,--thinlto-jobs=all,--gc-sections,--icf=all,-O3,--lto-O3,--lto-CGO3,--disable-runtime-pseudo-reloc,--disable-auto-import,--pdb=,${MINGW_INSTALL_PREFIX}/lib/sleefmath.o,${MINGW_INSTALL_PREFIX}/lib/llvmlibc.a,${MINGW_INSTALL_PREFIX}/lib/libsleefgnuabi.a
)
ExternalProject_Add(llvm-bolt
    URL https://www.sqlite.org/2026/sqlite-amalgamation-3510300.zip
    URL_HASH SHA3_256=ced02ff9738970f338c9c8e269897b554bcda73f6cf1029d49459e1324dbeaea
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
    COMMAND ${EXEC} ln -s ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr ld.lld 2>/dev/null || true
    COMMAND ${EXEC} mkdir -p ${CMAKE_INSTALL_PREFIX}/llvm-bolt
    COMMAND ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang   ${bolt_training_common_args} ${llvm_mllvm_lto} -mllvm -unroll-full-max-count=0 -flto=thin -fwhole-program-vtables sqlite3.c shell.c -o sqlite3_lto.exe &
            ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang   ${bolt_training_common_args} ${MLLVM_FLAGS} -fno-lto -fno-whole-program-vtables sqlite3.c shell.c -o sqlite3.exe &
            ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang++ ${bolt_training_common_args} ${llvm_mllvm_lto} -mllvm -unroll-full-max-count=0 -flto=thin -fwhole-program-vtables ${SINGLE_SOURCE_LOCATION}/harfbuzz/src/harfbuzz.cc -shared "-DHB_EXTERN='[[gnu::dllexport]]'" -o harfbuzz_lto.dll &
            ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang++ ${bolt_training_common_args} ${MLLVM_FLAGS} -fno-lto -fno-whole-program-vtables ${SINGLE_SOURCE_LOCATION}/harfbuzz/src/harfbuzz.cc -shared "-DHB_EXTERN='[[gnu::dllexport]]'" -o harfbuzz.dll
    COMMAND ${EXEC} rm sqlite3.exe sqlite3_lto.exe harfbuzz.dll harfbuzz_lto.dll ld.lld ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr
    COMMAND ${EXEC} merge-fdata ${CMAKE_INSTALL_PREFIX}/llvm-bolt/* -o llvm.fdata
    COMMAND ${EXEC} rm -r ${CMAKE_INSTALL_PREFIX}/llvm-bolt
    COMMAND ${EXEC} llvm-bolt
        --data llvm.fdata
        ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm
        -o ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.bolt
        --align-blocks
        --bolt-info=false
        --cg-use-split-hot-size
        --cmov-conversion
        --dyno-stats
        --elim-link-veneers
        --eliminate-unreachable
        --fix-block-counts
        --fix-func-counts
        --frame-opt-rm-stores
        --frame-opt=all
        --group-stubs
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
        --reorder-blocks=ext-tsp
        --reorder-functions=cdsort
        --sctc-mode=always
        --simplify-conditional-tail-calls
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
