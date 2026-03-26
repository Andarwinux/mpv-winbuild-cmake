ExternalProject_Add(sqlite
    DEPENDS
        meson-wrap
    URL https://www.sqlite.org/2026/sqlite-amalgamation-3510300.zip
    URL_HASH SHA3_256=ced02ff9738970f338c9c8e269897b554bcda73f6cf1029d49459e1324dbeaea
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory ${src_meson_wrap}/subprojects/packagefiles/sqlite3 <SOURCE_DIR>
    COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dall-extensions=enabled
        -Dfts34=enabled
        -Dfts5=enabled
        -Dgeopoly=enabled
        -Drbu=enabled
        -Drtree=enabled
        -Dsession=enabled
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(sqlite install)
