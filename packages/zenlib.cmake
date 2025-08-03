ExternalProject_Add(zenlib
    GIT_REPOSITORY https://github.com/MediaArea/ZenLib.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR>/Project/CMake -B<BINARY_DIR>
        ${cmake_conf_args}
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> ninja -C <BINARY_DIR>
          COMMAND ${EXEC} sed -i [['s/-lpthread//g']] <BINARY_DIR>/libzen.pc
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(zenlib)
cleanup(zenlib install)
