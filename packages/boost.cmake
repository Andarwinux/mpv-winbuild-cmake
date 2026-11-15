ExternalProject_Add(boost
    URL https://github.com/boostorg/boost/releases/download/boost-1.93.0.beta1/boost-1.93.0.beta1-b2-nodocs.tar.xz
    URL_HASH SHA256=b34092b2967223351e9d0b9199546463c85ecb6e6aa70b4ea69d2b1f7d316416
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(boost install)
