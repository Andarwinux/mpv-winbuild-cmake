ExternalProject_Add(boost
    URL https://github.com/boostorg/boost/releases/download/boost-1.89.0.beta1/boost-1.89.0.beta1-b2-nodocs.tar.xz
    URL_HASH SHA256=496a3c8c41609d1411a5337aa6b62348ef7996523647a9ae27572ae5e0113dd4
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(boost install)
