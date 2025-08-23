# CMake-based LLVM MinGW-W64 Cross Toolchain

This thing’s primary use is to build Windows binaries of apps.

## Prerequisites

 -  You should also install Ninja and use CMake’s Ninja build file generator.

 -  As a build environment, any modern glibc Linux distribution *should* work.

## Setup Build Environment
### Manjaro / Arch Linux

These packages need to be installed first before compiling mpv:

    pacman -S git gyp mercurial ninja cmake meson ragel yasm nasm asciidoc enca gperf unzip p7zip clang lld libc++ libc++abi python-pip curl mimalloc ccache go
    
    pip3 install mako jsonschema

### Ubuntu Linux / WSL (Windows 10)

    apt-get install build-essential checkinstall bison flex gettext git mercurial ninja-build gyp cmake yasm nasm automake pkgconf libtool libtool-bin clang lld libc++1 libc++abi1 libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint re2c asciidoc python3-pip docbook2x unzip p7zip-full curl mimalloc ccache golang

    pip3 install meson mako jsonschema

**Note:**

* It is advised to use bash over dash. Set `sudo ln -sf /bin/bash /bin/sh`. Revert back by `sudo ln -sf /bin/dash /bin/sh`.
* To update package installed by pip, run `pip3 install <package> --upgrade`.
* Distributions clang is usually problematic, it is highly recommended to install Fuchsia Clang as an alternative:

 ```
go install go.chromium.org/luci/cipd/client/cmd/...@latest
cipd install fuchsia/third_party/clang/linux-amd64 latest -root /usr/local/fuchsia-clang
PATH="/usr/local/fuchsia-clang/bin:$PATH"
```

## Compiling with Clang

Supported target architecture (`TARGET_ARCH`) with clang is: `x86_64-w64-mingw32`, `aarch64-w64-mingw32`.

Example:

    cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
    -DCMAKE_INSTALL_PREFIX="$PWD/clang_root" \
    -DMARCH=x86-64-v3 \
    -DSINGLE_SOURCE_LOCATION="$PWD/src_packages" \
    -G Ninja -B build_x86_64_v3 -S mpv-winbuild-cmake

The cmake command will create `clang_root` as clang sysroot where llvm tools installed. `build_x86_64` is build directory to compiling packages.

    cd build_x86_64
    ninja toolchains-download # download llvm
    ninja llvm       # build LLVM (take around ~2 hours)
    ninja llvm-clang # build clang on specified target
    ninja download   # download packages
    ninja fullclean && ninja download # workaround to avoid problems
    ninja mpv        # build mpv and all its dependencies

If you want add another target (ex. `aarch64-w64-mingw32`), change `TARGET_ARCH` and build folder.

    cmake -DTARGET_ARCH=aarch64-w64-mingw32 \
    -DCMAKE_INSTALL_PREFIX="$PWD/clang_root" \
    -DSINGLE_SOURCE_LOCATION="$PWD/src_packages" \
    -G Ninja -B build_aarch64 -S mpv-winbuild-cmake
    cd build_aarch64
    ninja llvm-clang # same as above

If you've changed `MARCH` option, you need to run:

    ninja rebuild_cache

to update flags which will pass on gcc, g++ and etc.

## Building Software (Second Time)

To build mpv for a second time:

    ninja update # perform git pull on all packages that used git

After that, build mpv as usual:

    ninja mpv

## CMake Options

| Options                      | Description                                                                                                                 | Default                                        |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------------- |------------------------------------------------|
| TARGET_ARCH                  | the target to build. available: x86_64-w64-mingw32, aarch64-w64-mingw32                                                     | x86_64-w64-mingw32                             |
| MARCH                     | for a specific microarchitecture. For x86_64, this means -march, for aarch64, this means -mcpu                              | x86_64:x86-64-v3 aarch64:cortex-a76            |
| CMAKE_INSTALL_PREFIX         | location of the host toolchain installation                                                                                 | `${CMAKE_CURRENT_BINARY_DIR}/install`          |
| SINGLE_SOURCE_LOCATION       | location of the packages source                                                                                             | `${CMAKE_CURRENT_BINARY_DIR}/src_packages`     |
| MINGW_INSTALL_PREFIX         | location of the MinGW sysroot                                                                                               | `${CMAKE_INSTALL_PREFIX}/${TARGET_ARCH}`       |
| ENABLE_CCACHE                | ccache integration                                                                                                          | OFF                                            |
| CCACHE_MAXSIZE               | ccache size                                                                                                                 | 500M                                           |
| MALLOC                       | malloc for LD_PRELOAD                                                                                                       | /usr/lib/libmimalloc.so /usr/lib/libjemalloc.so|
| CLANG_PACKAGES_PGO           | IRPGO for packages                                                                                                          | OFF                                            |
|                              | GEN: build packages with profile instrumentation                                                                            |                                                |
|                              | USE: build packages with profdata                                                                                           |                                                |
| CLANG_PACKAGES_PROFDATA_FILE | path to your profdata                                                                                                       |                                                |
| CLANG_FLAGS                  | FLAGS passed to clang                                                                                                       |                                                |
| LLD_FLAGS                    | FLAGS passed to lld                                                                                                         |                                                |
| TOOLCHAIN_FLAGS              | CFLAGS passed to host compiler when build LLVM                                                                              |                                                |
| LLVM_ENABLE_LTO              | Build LLVM with LTO                                                                                                         | OFF                                            |
|                              | Thin: use ThinLTO                                                                                                           |                                                |
|                              | Full: use FullLTO                                                                                                           |                                                |
| LLVM_ENABLE_PGO              | Build LLVM with PGO                                                                                                         | OFF                                            |
|                              | GEN: build LLVM with IR profile instrumentation                                                                             |                                                |
|                              | CSGEN: build LLVM with CSIR profile instrumentation and profdata                                                            |                                                |
|                              | USE: build LLVM with profdata                                                                                               |                                                |
| LLVM_PROFDATA_FILE           | path to your LLVM profdata                                                                                                  |                                                |
| CUSTOM_LIBCXX                | use bundled libcxx instead of default cxx stdlib to build LLVM, Don't enable it unless you know what it does                | OFF                                            |
| CUSTOM_COMPILER_RT           | use bundled compiler-rt builtins instead of default compiler-rt to build LLVM, Don't enable it unless you know what it does | OFF                                            |



## Available Commands

| Commands                   | Description |
| -------------------------- | ----------- |
| ninja package              | compile a package |
| ninja clean                | remove all stamp files in all packages. |
| ninja fullclean            | remove all stamp and build files in all packages |
| ninja download             | Download all packages' sources at once without compiling. |
| ninja patch                | patch all packages |
| ninja update               | Update all git repos. When a package pulls new changes, all of its stamp files will be deleted and will be forced rebuild. If there is no change, it will not remove the stamp files and no rebuild occur. Use this instead of `ninja clean` if you don't want to rebuild everything in the next run. |
| ninja toolchains-fullclean  | remove all stamp and build files in all toolchain packages |
| ninja toolchains-download   | Download all toolchain packages' sources at once without compiling. |
| ninja toolchains-update     | Update all toolchain git repos. When a package pulls new changes, all of its stamp files will be deleted and will be forced rebuild. If there is no change, it will not remove the stamp files and no rebuild occur. Use this instead of `ninja clean` if you don't want to rebuild everything in the next run. |
| ninja package-fullclean    | Remove all stamp files of a package. |
| ninja package-removebuild  | Remove 'build' directory of a package. |
| ninja package-removeprefix | Remove 'prefix' directory. |
| ninja package-force-update | Update a package. Only git repo will be updated. |
| ninja ccache-recomp         | Recompress ccache cache. |

`package` is package's name found in `packages` folder.

## Information about packages

- Apps
    - mpv
    - FFmpeg
    - qBittorrent-Enhanced-Edition
    - curl
    - svtav1-psy
    - mediainfo

- Git deps
    - amf-headers
    - ANGLE
    - aom
    - avisynth-headers
    - brotli
    - bzip2
    - c-ares
    - curl
    - dav1d
    - fast_float
    - FFmpeg
    - fontconfig
    - freetype2
    - fribidi
    - game-music-emu
    - glad
    - glslang
    - graphengine
    - harfbuzz
    - highway
    - lcms2
    - libarchive
    - libaribcaption
    - libass
    - libbluray
    - libdovi
    - libdvdcss
    - libdvdnav
    - libdvdread
    - libhdr10plus
    - libjpeg
    - libjxl
    - liblc3
    - libmediainfo
    - libmediainfo
    - libmodplug
    - libmysofa
    - libplacebo
    - libpng
    - libpsl
    - libsamplerate
    - libsdl2
    - libsixel
    - libsoxr
    - libsrt
    - libssh
    - libtorrent
    - libudfread
    - libunibreak
    - libva
    - libvidstab
    - libvpl
    - libvpx
    - libwebp
    - libxml2
    - libzimg
    - luajit
    - mimalloc
    - mpv
    - mpv-debug-plugin
    - mpv-menu-plugin
    - mujs
    - nghttp2
    - nghttp3
    - ngtcp2
    - nvcodec-headers
    - ogg
    - openal-soft
    - opencl
    - opencl-header
    - openssl
    - opus
    - qt-base
    - qt-svg
    - qt-tools
    - rubberband
    - shaderc
    - sleef
    - speex
    - spirv-cross
    - spirv-headers
    - spirv-tools
    - svtav1
    - uchardet
    - vorbis
    - vulkan
    - vulkan-header
    - vvenc
    - x265
    - xxhash
    - xz
    - zenlib
    - zenlib
    - zlib-ng
    - zstd

- Zip deps
    - libiconv (1.18)
    - lzo (2.10)
    - vapoursynth (R70)
    - boost (1.87.0)


### WSL workaround

Place the file on specified location to limit ram & cpu usage to avoid getting stuck while building mpv.

Recommended 3GB per CPU

    # /etc/wsl.conf
    [interop]
    enabled=false
    appendWindowsPath=false
    ---------------------------------------
    # C:\Users\<UserName>\.wslconfig
    [wsl2]
    processors=8
    memory=24GB
    swap=0
    [experimental]
    autoMemoryReclaim=dropcache
    sparseVhd=true