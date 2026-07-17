ExternalProject_Add(boost
    URL https://github.com/boostorg/boost/releases/download/boost-1.92.0.beta1/boost-1.92.0.beta1-b2-nodocs.tar.xz
    URL_HASH SHA256=97bcc12929a59c83d4c9505bc46790f0fef4ef5d1749ce9499d770ada0ef1b82
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(boost install)
