set_property(DIRECTORY PROPERTY EP_STEP_TARGETS download patch configure build install)
include(${PROJECT_SOURCE_DIR}/cmake/packages_check.cmake)
list(APPEND ep
    xz
    lzo
    uchardet
    sleef
    libsamplerate
    rubberband
    zlib
    zstd
    bzip2
    libjpeg
    lcms2
    ogg
    vorbis
    opus-dnn
    opus
    speex
    libmodplug
    libvpx
    game-music-emu
    libpng
    x265
    libdvdcss
    libdvdread
    libdvdnav
    libiconv
    meson-wrap
    luajit
    fribidi
    libxml2
    brotli
    freetype2
    libudfread
    libbluray
    harfbuzz
    libsoxr
    graphengine
    libzimg
    fontconfig
    libunibreak
    libass
    libvpl
    amf-headers
    avisynth-headers
    nvcodec-headers
    libmysofa
    aom
    xxhash
    dav1d
    libwebp
    vapoursynth
    openssl
    libssh
    libsrt
    libarchive
    highway
    libjxl
    angle-headers
    mujs
    spirv-headers
    spirv-tools
    spirv-cross
    glslang
    vulkan-header
    vulkan
    libsdl2
    openal-soft
    shaderc
    glad
    fast_float
    svtav1
    svtav1-psy
    libplacebo
    libva
    libaribcaption
    libsixel
    opencl-header
    opencl
    fdk-aac
    liblc3
    libvidstab
    frei0r
    vvenc
    codec2
    ffmpeg
    mpv
    mpv-packaging
    ngtcp2
    nghttp3
    nghttp2
    c-ares
    libpsl
    curl
    mpv-debug-plugin
    mpv-menu-plugin
    sqlite
    libssh2
    aria2
    zenlib
    libmediainfo
    mediainfo
    mimalloc
    qt6-qtbase
    qt6-qttools
    qt6-qtsvg
    boost
    libtorrent
    qbittorrent
)
foreach(package IN LISTS ep)
    if(NOT ${SINGLE_SOURCE_LOCATION} STREQUAL "")
        set(SOURCE_LOCATION "${SINGLE_SOURCE_LOCATION}/${package}")
    endif()
    include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
    set(SOURCE_LOCATION "")

    get_property(_git_repository TARGET ${package} PROPERTY _EP_GIT_REPOSITORY)
    if(_git_repository)
        list(APPEND repo ${package})
    endif()
endforeach()
list(LENGTH ep ep_length)
message(STATUS "Parsing ${ep_length} packages")

# Exclude packages which dont depend on mpv when update
list(APPEND removed "vvenc x265")
list(REMOVE_ITEM repo ${removed})
list(REMOVE_ITEM ep ${removed})
list(TRANSFORM repo APPEND "-force-update" OUTPUT_VARIABLE update)
list(TRANSFORM ep APPEND "-download" OUTPUT_VARIABLE download)
list(TRANSFORM ep APPEND "-fullclean" OUTPUT_VARIABLE fullclean)

add_custom_target(update
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${update}
    COMMENT "Updating git repo"
)

add_custom_target(download
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${download}
)

add_custom_target(fullclean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${fullclean}
    COMMENT "Remove all build and stamp files, reset git HEAD"
)

add_custom_target(ccache-recomp
    COMMAND ${EXEC} ccache -X 22
    USES_TERMINAL
)
