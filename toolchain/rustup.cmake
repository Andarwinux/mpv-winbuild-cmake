ExternalProject_Add(rustup
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR rustup-prefix/src
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${EXEC} GOBIN=${CMAKE_INSTALL_PREFIX}/bin go install go.chromium.org/luci/cipd/client/cmd/...@latest
          COMMAND ${EXEC} cipd init -force ${RUSTUP_LOCATION}
          COMMAND ${EXEC} cipd install fuchsia/third_party/rust/host/linux-amd64 latest -root ${RUSTUP_LOCATION} -force
          COMMAND ${EXEC} cipd install fuchsia/third_party/rust/target/x86_64-unknown-linux-gnu latest -root ${RUSTUP_LOCATION} -force
    INSTALL_COMMAND ${EXEC} LD_PRELOAD= cargo install cargo-c --profile=release-strip --features=vendored-openssl --locked
    LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(rustup install)
