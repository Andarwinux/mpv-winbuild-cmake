set(PC_VERSION "72")
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/vapoursynth.pc.in ${CMAKE_CURRENT_BINARY_DIR}/vapoursynth.pc @ONLY)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/vapoursynth-script.pc.in ${CMAKE_CURRENT_BINARY_DIR}/vapoursynth-script.pc @ONLY)

ExternalProject_Add(vapoursynth
    GIT_REPOSITORY https://github.com/vapoursynth/vapoursynth.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /include !include/cython"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG master
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
          COMMAND ${EXEC} ${TARGET_ARCH}-dlltool -m ${dlltool_image} -d ${CMAKE_CURRENT_SOURCE_DIR}/VapourSynth.def -l VapourSynth.lib
          COMMAND ${EXEC} ${TARGET_ARCH}-dlltool -m ${dlltool_image} -d ${CMAKE_CURRENT_SOURCE_DIR}/VSScript.def -l VSScript.lib
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/include ${MINGW_INSTALL_PREFIX}/include/vapoursynth
            COMMAND ${CMAKE_COMMAND} -E copy VapourSynth.lib ${MINGW_INSTALL_PREFIX}/lib/VapourSynth.lib
            COMMAND ${CMAKE_COMMAND} -E copy VSScript.lib ${MINGW_INSTALL_PREFIX}/lib/VSScript.lib
            COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/vapoursynth.pc ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/vapoursynth.pc
            COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/vapoursynth-script.pc ${MINGW_INSTALL_PREFIX}/lib/pkgconfig/vapoursynth-script.pc
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(vapoursynth)
cleanup(vapoursynth install)
