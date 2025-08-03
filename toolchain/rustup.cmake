string(TOLOWER "${CMAKE_HOST_SYSTEM_PROCESSOR}" host_arch)
if(host_arch STREQUAL "x86_64" OR host_arch STREQUAL "amd64")
    set(cipd_rust_arch "amd64")
    set(cipd_rust_std_arch "x86_64")
elseif(host_arch STREQUAL "aarch64" OR host_arch STREQUAL "arm64")
    set(cipd_rust_arch "arm64")
    set(cipd_rust_std_arch "aarch64")
endif()
ExternalProject_Add(rustup
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR rustup-prefix/src
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${EXEC_HOST} GOBIN=${CMAKE_INSTALL_PREFIX}/bin go install go.chromium.org/luci/cipd/client/cmd/...@latest
          COMMAND ${EXEC_HOST} cipd init -force ${RUSTUP_LOCATION}
          COMMAND ${EXEC_HOST} cipd install fuchsia/third_party/rust/host/linux-${cipd_rust_arch} latest -root ${RUSTUP_LOCATION} -force
          COMMAND ${EXEC_HOST} cipd install fuchsia/third_party/rust/target/${cipd_rust_std_arch}-unknown-linux-gnu latest -root ${RUSTUP_LOCATION} -force
    INSTALL_COMMAND ${EXEC_HOST} LD_PRELOAD= CC=${CMAKE_C_COMPILER} CXX=${CMAKE_CXX_COMPILER} AR=${CMAKE_C_COMPILER_AR} "CFLAGS='-O3 -march=native -fno-ident -fno-plt -fno-semantic-interposition -ffp-contract=fast -fno-math-errno'" "CXXFLAGS='-O3 -march=native -fno-ident -fno-plt -fno-semantic-interposition -ffp-contract=fast -fno-math-errno'" "RUSTFLAGS='-Ctarget-cpu=native -Copt-level=3 -Cllvm-args=-fp-contract=fast -Clink-arg=-Wl,-Bsymbolic,--build-id=none,-O3,--lto-O3,--lto-CGO3,--icf=all,--gc-sections,-znow,-zrodynamic,-zpack-relative-relocs,-zcommon-page-size=2097152,-zmax-page-size=2097152,-zseparate-loadable-segments,-zkeep-text-section-prefix,-zstart-stop-visibility=hidden'" cargo install cargo-c --profile=release --locked
    LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(rustup install)
