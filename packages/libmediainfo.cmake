ExternalProject_Add(libmediainfo
    DEPENDS
        zlib
        zenlib
    GIT_REPOSITORY https://github.com/MediaArea/MediaInfoLib.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} sed -i [['/MediaInfoDLL\.rc/d']] <SOURCE_DIR>/Project/CMake/CMakeLists.txt
    COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR>/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_ZLIB=OFF
        -DBUILD_ZENLIB=OFF
        -DCURL_FOUND=OFF
        -DCMAKE_DISABLE_FIND_PACKAGE_CURL=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_TinyXML=ON
        "-DCMAKE_CXX_FLAGS='-DFMT_HEADER_ONLY'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_EXCEPTIONS_ALLOWED=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
          COMMAND ${EXEC} sed -i [['s/-lpthread//g']] <BINARY_DIR>/libmediainfo.pc
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libmediainfo)
cleanup(libmediainfo install)
