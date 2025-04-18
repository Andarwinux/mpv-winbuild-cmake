# CMake-based LLVM MinGW-W64 Cross Toolchain

This thing’s primary use is to build Windows binaries of apps.

## Prerequisites

 -  You should also install Ninja and use CMake’s Ninja build file generator.
    It’s not only much faster than GNU Make, but also far less error-prone,
    which is important for this project because CMake’s ExternalProject module
    tends to generate makefiles which confuse GNU Make’s jobserver thingy.

 -  As a build environment, any modern glibc Linux distribution *should* work.

## Setup Build Environment
### Manjaro / Arch Linux

These packages need to be installed first before compiling mpv:

    pacman -S git gyp mercurial subversion ninja cmake meson ragel yasm nasm asciidoc enca gperf unzip p7zip gcc-multilib clang lld libc++ libc++abi python-pip curl lib32-gcc-libs lib32-glib2 mimalloc ccache
    
    pip3 install mako jsonschema

    pacman -S llvm # needed for building LLVM PGO

### Ubuntu Linux / WSL (Windows 10)

    apt-get install build-essential checkinstall bison flex gettext git mercurial subversion ninja-build gyp cmake yasm nasm automake pkgconf libtool libtool-bin gcc-multilib g++-multilib clang lld libc++1 libc++abi1 libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint re2c asciidoc python3-pip docbook2x unzip p7zip-full curl mimalloc ccache

    pip3 install meson mako jsonschema

**Note:**

* Use [apt-fast](https://github.com/ilikenwf/apt-fast) if apt-get is too slow.
* It is advised to use bash over dash. Set `sudo ln -sf /bin/bash /bin/sh`. Revert back by `sudo ln -sf /bin/dash /bin/sh`.
* To update package installed by pip, run `pip3 install <package> --upgrade`.

## Compiling with Clang

Supported target architecture (`TARGET_ARCH`) with clang is: `x86_64-w64-mingw32`, `aarch64-w64-mingw32`.

Example:

    cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
    -DCMAKE_INSTALL_PREFIX="/home/user/clang_root" \
    -DCOMPILER_TOOLCHAIN=clang \
    -DGCC_ARCH=x86-64-v3 \
    -DSINGLE_SOURCE_LOCATION="/home/user/packages" \
    -DRUSTUP_LOCATION="/home/user/install_rustup" \
    -DMINGW_INSTALL_PREFIX="/home/user/build_x86_64_v3/x86_64_v3-w64-mingw32" \
    -G Ninja -B build_x86_64_v3 -S mpv-winbuild-cmake

The cmake command will create `clang_root` as clang sysroot where llvm tools installed. `build_x86_64` is build directory to compiling packages.

    cd build_x86_64
    ninja llvm       # build LLVM (take around ~2 hours)
    ninja rustup     # build rust toolchain
    ninja llvm-clang # build clang on specified target
    ninja mpv        # build mpv and all its dependencies

If you want add another target (ex. `aarch64-w64-mingw32`), change `TARGET_ARCH` and build folder.

    cmake -DTARGET_ARCH=aarch64-w64-mingw32 \
    -DCMAKE_INSTALL_PREFIX="/home/user/clang_root" \
    -DCOMPILER_TOOLCHAIN=clang \
    -DSINGLE_SOURCE_LOCATION="/home/user/packages" \
    -DRUSTUP_LOCATION="/home/user/install_rustup" \
    -DMINGW_INSTALL_PREFIX="/home/user/build_aarch64/aarch64-w64-mingw32" \
    -G Ninja -B build_aarch64 -S mpv-winbuild-cmake
    cd build_aarch64
    ninja llvm-clang # same as above

If you've changed `GCC_ARCH` option, you need to run:

    ninja rebuild_cache

to update flags which will pass on gcc, g++ and etc.

## Building Software (Second Time)

To build mpv for a second time:

    ninja update # perform git pull on all packages that used git

After that, build mpv as usual:

    ninja mpv

## Available Commands

| Commands                   | Description |
| -------------------------- | ----------- |
| ninja package              | compile a package |
| ninja clean                | remove all stamp files in all packages. |
| ninja fullclean            | remove all stamp and build files in all packages |
| ninja download             | Download all packages' sources at once without compiling. |
| ninja update               | Update all git repos. When a package pulls new changes, all of its stamp files will be deleted and will be forced rebuild. If there is no change, it will not remove the stamp files and no rebuild occur. Use this instead of `ninja clean` if you don't want to rebuild everything in the next run. |
| ninja toolchains-fullclean  | remove all stamp and build files in all toolchain packages |
| ninja toolchains-download   | Download all toolchain packages' sources at once without compiling. |
| ninja toolchains-update     | Update all toolchain git repos. When a package pulls new changes, all of its stamp files will be deleted and will be forced rebuild. If there is no change, it will not remove the stamp files and no rebuild occur. Use this instead of `ninja clean` if you don't want to rebuild everything in the next run. |
| ninja package-fullclean    | Remove all stamp files of a package. |
| ninja package-removebuild  | Remove 'build' directory of a package. |
| ninja package-removeprefix | Remove 'prefix' directory. |
| ninja package-force-update | Update a package. Only git repo will be updated. |

`package` is package's name found in `packages` folder.

## Information about packages

- Git/Hg
    - amf-headers
    - ANGLE
    - aom
    - avisynth-headers
    - brotli
    - bzip2
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
    - libjpeg
    - libjxl
    - libmediainfo
    - libmodplug
    - libmysofa
    - libplacebo
    - libpng
    - libsamplerate
    - libsdl2
    - libsixel
    - libsoxr
    - libsrt
    - libssh
    - libudfread
    - libunibreak
    - libva
    - libvpl
    - libvpx
    - libwebp
    - libxml2
    - libzimg
    - libzvbi
    - luajit
    - mpv
    - mpv-debug-plugin
    - mpv-menu-plugin
    - mujs
    - nvcodec-headers
    - ogg
    - openal-soft
    - opencl
    - opencl-header
    - openssl
    - opus
    - rubberband
    - shaderc
    - speex
    - spirv-cross
    - spirv-headers
    - spirv-tools
    - svtav1
    - uchardet
    - vorbis
    - vulkan
    - vulkan-header
    - x265
    - xxhash
    - xz
    - zenlib
    - zlib-ng
    - zstd

- Zip
    - libiconv (1.18)
    - lzo (2.10)
    - vapoursynth (R70)


### WSL workaround

Place the file on specified location to limit ram & cpu usage to avoid getting stuck while building mpv.

    # /etc/wsl.conf
    [interop]
    #enabled=false
    appendWindowsPath=false
    ---------------------------------------
    # C:\Users\<UserName>\.wslconfig
    [wsl2]
    memory=16GB
    swap=0
    [experimental]
    autoMemoryReclaim=dropcache
    sparseVhd=true