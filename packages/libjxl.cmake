get_property(src_libjpeg TARGET libjpeg PROPERTY _EP_SOURCE_DIR)
ExternalProject_Add(libjxl
    DEPENDS
        lcms2
        libpng
        zlib
        libjpeg
        brotli
        highway
    GIT_REPOSITORY https://github.com/libjxl/libjxl.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_REMOTE_NAME origin
    GIT_TAG main
    GIT_SUBMODULES ""
    GIT_CONFIG "submodule.recurse=false"
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ""
    COMMAND ${CMAKE_COMMAND} -E rm -rf <SOURCE_DIR>/third_party/libjpeg-turbo
    COMMAND ${CMAKE_COMMAND} -E create_symlink ${src_libjpeg} <SOURCE_DIR>/third_party/libjpeg-turbo
    COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DCMAKE_POSITION_INDEPENDENT_CODE=ON
        -DJPEGXL_STATIC=ON
        -DJPEGXL_EMSCRIPTEN=OFF
        -DJPEGXL_BUNDLE_LIBPNG=OFF
        -DJPEGXL_ENABLE_TOOLS=OFF
        -DJPEGXL_ENABLE_VIEWERS=OFF
        -DJPEGXL_ENABLE_DOXYGEN=OFF
        -DJPEGXL_ENABLE_EXAMPLES=OFF
        -DJPEGXL_ENABLE_MANPAGES=OFF
        -DJPEGXL_ENABLE_JNI=OFF
        -DJPEGXL_ENABLE_SKCMS=OFF
        -DJPEGXL_ENABLE_PLUGINS=OFF
        -DJPEGXL_ENABLE_DEVTOOLS=OFF
        -DJPEGXL_ENABLE_BENCHMARK=OFF
        -DJPEGXL_ENABLE_SJPEG=OFF
        -DJPEGXL_ENABLE_AVX512=ON
        -DJPEGXL_ENABLE_AVX512_ZEN4=ON
        -DJPEGXL_ENABLE_AVX512_SPR=ON
        -DJPEGXL_FORCE_SYSTEM_LCMS2=ON
        -DJPEGXL_FORCE_SYSTEM_BROTLI=ON
        -DJPEGXL_FORCE_SYSTEM_HWY=ON
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _IS_UNWIND_ALLOWED=set:1
        _FORCE_HIDE_DLLEXPORT=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libjxl)
cleanup(libjxl install)
