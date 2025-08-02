ExternalProject_Add(cppwinrt
    GIT_REPOSITORY https://github.com/microsoft/cppwinrt.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        -GNinja
        -DCMAKE_BUILD_TYPE=Release
        -DBUILD_SHARED_LIBS=OFF
        -DCMAKE_C_COMPILER=clang
        -DCMAKE_CXX_COMPILER=clang++
        -DCMAKE_ASM_COMPILER=clang
        -DCMAKE_C_COMPILER_WORKS=ON
        -DCMAKE_CXX_COMPILER_WORKS=ON
        -DCMAKE_ASM_COMPILER_WORKS=ON
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND ${EXEC_HOST} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC_HOST} ${CMAKE_COMMAND} --install <BINARY_DIR>
            COMMAND ${EXEC_HOST} wget -O <BINARY_DIR>/Windows.winmd  https://github.com/microsoft/windows-rs/raw/master/crates/libs/bindgen/default/Windows.winmd
            COMMAND ${EXEC_HOST} cppwinrt -input <BINARY_DIR>/Windows.winmd -output ${MINGW_INSTALL_PREFIX}/include/
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(cppwinrt)
cleanup(cppwinrt install)
