ExternalProject_Add(libhdr10plus
    GIT_REPOSITORY https://github.com/quietvoid/hdr10plus_tool.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone hdr10plus"
    GIT_REMOTE_NAME origin
    GIT_TAG main
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${EXEC}
        LD_PRELOAD=
        CARGO_BUILD_TARGET_DIR=<BINARY_DIR>
        ${cargo_lto_rustflags}
        cargo cinstall
        --manifest-path <SOURCE_DIR>/hdr10plus/Cargo.toml
        --prefix ${MINGW_INSTALL_PREFIX}
        --target ${TARGET_CPU}-pc-windows-gnullvm
        -Zbuild-std=std,panic_abort
        -Zbuild-std-features=sysroot/system-llvm-libunwind,sysroot/panic_immediate_abort,sysroot/backtrace-trace-only
        --release
        --library-type staticlib
    INSTALL_COMMAND  ${EXEC} llvm-ar t ${MINGW_INSTALL_PREFIX}/lib/libhdr10plus-rs.a | grep '^compiler_builtins.*\.o$' | xargs -I {} llvm-ar d ${MINGW_INSTALL_PREFIX}/lib/libhdr10plus-rs.a {}
            COMMAND ${EXEC} llvm-ar t ${MINGW_INSTALL_PREFIX}/lib/libhdr10plus-rs.a | grep '^unwind.*\.o$' | xargs -I {} llvm-ar d ${MINGW_INSTALL_PREFIX}/lib/libhdr10plus-rs.a {}
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libhdr10plus)
cleanup(libhdr10plus install)
