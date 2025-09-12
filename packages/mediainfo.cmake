ExternalProject_Add(mediainfo
    DEPENDS
        libmediainfo
    GIT_REPOSITORY https://github.com/MediaArea/MediaInfo.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !Source/GUI"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR> <BINARY_DIR>
    COMMAND ${EXEC} cd Project/GNU/CLI && autoreconf -fi && ${EXEC} ./configure
        ${autoshit_confuck_args}
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${MAKE} -C Project/GNU/CLI
    INSTALL_COMMAND ${MAKE} install -C Project/GNU/CLI
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mediainfo)
cleanup(mediainfo install)
