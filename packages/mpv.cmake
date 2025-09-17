if(NOT DEFINED CMAKE_SCRIPT_MODE_FILE)
    set(mpv_conf
        ${meson_conf_args}
        -Db_lto_mode=thin
        -Db_lto=true
        -Dbuild-date=true
        -Dcplugins=enabled
        -Dcuda-hwaccel=enabled
        -Dcuda-interop=enabled
        -Dd3d-hwaccel=enabled
        -Dd3d11=enabled
        -Dd3d9-hwaccel=enabled
        -Ddirect3d=enabled
        -Ddvdnav=enabled
        -Degl-angle=enabled
        -Dgl-dxinterop-d3d9=enabled
        -Dgl-dxinterop=enabled
        -Dgl-win32=enabled
        -Dgl=enabled
        -Diconv=enabled
        -Djavascript=enabled
        -Djpeg=enabled
        -Dlcms2=enabled
        -Dlibarchive=enabled
        -Dlibavdevice=enabled
        -Dlibbluray=enabled
        -Dlua=luajit
        -Dopenal=enabled
        -Drubberband=enabled
        -Dsdl2-audio=enabled
        -Dsdl2-gamepad=enabled
        -Dsdl2-video=enabled
        -Dsdl2=enabled
        -Dshaderc=enabled
        -Dsixel=enabled
        -Dspirv-cross=enabled
        -Duchardet=enabled
        -Dvaapi-win32=enabled
        -Dvaapi=enabled
        -Dvapoursynth=enabled
        -Dvector=enabled
        -Dvulkan=enabled
        -Dwasapi=enabled
        -Dwin32-smtc=enabled
        -Dwin32-subsystem=console
        -Dwin32-threads=enabled
        -Dzimg=enabled
        -Dzlib=enabled
    )
    ExternalProject_Add(mpv
        DEPENDS
            angle-headers
            nvcodec-headers
            ffmpeg
            fribidi
            lcms2
            libarchive
            libass
            libdvdnav
            libdvdread
            libiconv
            libjpeg
            libpng
            luajit
            rubberband
            uchardet
            openal-soft
            mujs
            vulkan
            shaderc
            libplacebo
            spirv-cross
            vapoursynth
            libsdl2
            libsixel
        GIT_REPOSITORY https://github.com/mpv-player/mpv.git
        SOURCE_DIR ${SOURCE_LOCATION}
        GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
        GIT_PROGRESS TRUE
        UPDATE_COMMAND ""
        CONFIGURE_ENVIRONMENT_MODIFICATION
            _IS_CONFIGURE=set:1
        CONFIGURE_COMMAND ${EXEC} meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
            ${mpv_conf}
            -Dlibmpv=true
            -Dcplayer=true
        ${trim_path} <BINARY_DIR>/config.h
        BUILD_ENVIRONMENT_MODIFICATION
            _PACKAGE_NAME=set:${package}
            _BINARY_DIR=set:<BINARY_DIR>
            _IS_EXCEPTIONS_ALLOWED=set:1
            _FORCE_HIDE_DLLEXPORT=set:1
            _FULL_DEBUGINFO=set:1
            _PDB_GENERATE=set:1
        BUILD_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
        INSTALL_COMMAND ""
        LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
    )

    get_property(mpv_src TARGET mpv PROPERTY _EP_SOURCE_DIR)
    if(ENABLE_LEGACY_MPV)
    set(copy-binary-dep build-legacy)
    ExternalProject_Add_Step(mpv build-legacy
        DEPENDEES install
        LOG 1
        COMMAND ${EXEC} _IS_CONFIGURE=1 meson setup --reconfigure <BINARY_DIR>/legacy <SOURCE_DIR>
            ${mpv_conf}
            -Dlibmpv=false
            -Dcplayer=true
            -Dwin32-subsystem=windows
        ${trim_path} <BINARY_DIR>/legacy/config.h
        COMMAND ${EXEC} _PDB_GENERATE=1 _IS_EXCEPTIONS_ALLOWED=1 _FORCE_HIDE_DLLEXPORT=1 _FULL_DEBUGINFO=1 ninja -C <BINARY_DIR>/legacy mpv.exe
        COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/legacy/mpv.exe <BINARY_DIR>/mpv-package/mpv-legacy.exe
    )
    else()
    set(copy-binary-dep install)
    endif()

    ExternalProject_Add_Step(mpv copy-binary
        DEPENDEES ${copy-binary-dep}
        COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.exe <BINARY_DIR>/mpv-package/mpv.exe
        COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.pdb <BINARY_DIR>/mpv-package/mpv.pdb
        COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/etc/mpv-register.bat <BINARY_DIR>/mpv-package/mpv-register.bat
        COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/etc/mpv-unregister.bat <BINARY_DIR>/mpv-package/mpv-unregister.bat
        COMMENT "Copying mpv binaries"
    )

    ExternalProject_Add_Step(mpv copy-package-dir
        DEPENDEES copy-binary
        COMMAND ${CMAKE_COMMAND}
        -DGIT_EXECUTABLE=${GIT_EXECUTABLE}
        -Dmpv_src=${mpv_src}
        -DSOURCE=<BINARY_DIR>/mpv-package
        -DTARGET=${CMAKE_BINARY_DIR}/mpv-${TARGET_CPU}${MARCH_NAME}-${BUILDDATE}-git
        -P${CMAKE_CURRENT_LIST_FILE}
        COMMENT "Moving mpv package folder"
        LOG 1
    )

    force_rebuild_git(mpv)
    cleanup(mpv copy-package-dir)
else()
    execute_process(COMMAND ${GIT_EXECUTABLE} -C ${mpv_src} rev-parse --short=7 HEAD OUTPUT_VARIABLE GIT OUTPUT_STRIP_TRAILING_WHITESPACE)
    execute_process(COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different  ${SOURCE} ${TARGET}-${GIT})
endif()
