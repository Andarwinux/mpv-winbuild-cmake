ExternalProject_Add(libmediainfo
    DEPENDS
        zlib
        zenlib
    GIT_REPOSITORY https://github.com/MediaArea/MediaInfoLib.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR>/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_SHARED_LIBS=ON
        -DBUILD_ZLIB=OFF
        -DBUILD_ZENLIB=OFF
        -DCURL_FOUND=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_CURL=ON
    BUILD_COMMAND ${EXEC} EXCEP=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
            COMMAND ${EXEC} rm -rf ${MINGW_INSTALL_PREFIX}/lib/libmediainfo.dll.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

get_property(source_dir TARGET libmediainfo PROPERTY _EP_SOURCE_DIR)

ExternalProject_Add(libmediainfo-static
    DEPENDS
        libmediainfo
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H${source_dir}/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_ZLIB=OFF
        -DBUILD_ZENLIB=OFF
        -DCURL_FOUND=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_CURL=ON
    BUILD_COMMAND ${EXEC} EXCEP=1 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libmediainfo)
cleanup(libmediainfo install)
cleanup(libmediainfo-static install)
