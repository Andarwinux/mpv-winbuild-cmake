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
    COMMAND ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang --target=${TARGET_CPU}-pc-windows-gnu --sysroot=${MINGW_INSTALL_PREFIX} -D_WIN32_WINNT=0x0A00 -DWINVER=0x0A00 -DNDEBUG -D__CRT__NO_INLINE -Xclang -mlong-double-64 -fno-temp-file -flto=thin -fwhole-program-vtables -fno-split-lto-unit -fuse-ld=lld --ld-path=$PWD/ld.lld -O3 -fno-auto-import -fdata-sections -ffunction-sections -funroll-loops -fstrict-flex-arrays=3 -falign-functions=32 -fno-signed-zeros -fno-trapping-math -freciprocal-math -fapprox-func -mrecip=all -ffp-contract=fast -fno-math-errno -fomit-frame-pointer -fmerge-all-constants -fno-unique-section-names -gcodeview -mguard=cf -Wl,-mllvm,-slp-revec,-mllvm,-disable-auto-upgrade-debug-info ${llvm_mllvm_lto} ${polly_lto} -g3 -Wl,--gc-sections,--icf=all,-O3,--lto-O3,--lto-CGO3,--disable-runtime-pseudo-reloc,--pdb= sqlite3.c shell.c -o sqlite3.exe
    COMMAND ${EXEC} ${CMAKE_INSTALL_PREFIX}/llvmbin/llvm.instr clang --target=${TARGET_CPU}-pc-windows-gnu --sysroot=${MINGW_INSTALL_PREFIX} -D_WIN32_WINNT=0x0A00 -DWINVER=0x0A00 -DNDEBUG -D__CRT__NO_INLINE -Xclang -mlong-double-64 -fno-temp-file -fno-split-lto-unit -fuse-ld=lld --ld-path=$PWD/ld.lld -O3 -fno-auto-import -fdata-sections -ffunction-sections -funroll-loops -fstrict-flex-arrays=3 -falign-functions=32 -fno-signed-zeros -fno-trapping-math -freciprocal-math -fapprox-func -mrecip=all -ffp-contract=fast -fno-math-errno -fomit-frame-pointer -fmerge-all-constants -fno-unique-section-names -gcodeview -mguard=cf -mllvm -slp-revec ${llvm_mllvm} ${polly} -g3 -Wl,--gc-sections,--icf=all,-O3,--lto-O3,--lto-CGO3,--disable-runtime-pseudo-reloc,--pdb= sqlite3.c shell.c -o sqlite3.exe
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
