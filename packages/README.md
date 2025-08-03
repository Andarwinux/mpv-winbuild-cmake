# packages

These files determine how to build a package and also hold patches to fix the build if necessary.

# Add a new package

## Before you start, please refer to the CMake ExternalProject [documentation](https://cmake.org/cmake/help/latest/module/ExternalProject.html).
You may notice there are some options in the files here that are not documented by CMake, because they were added via a local [patch](/packages/cmake-0001-ExternalProject-changes.patch).
CMake's implementation of the Git download method does not meet advanced needs such as [sparse checkout](https://git-scm.com/docs/git-sparse-checkout).

## To add a new package, first consider how to download it.

In general, [Git](https://cmake.org/cmake/help/latest/module/ExternalProject.html#id6) is the newest, fastest, and most space-efficient way to download packages. If you choose Git, then consider which Git repository to use, Github usually has the highest SLA.

The source code of many packages includes blobs and test cases that are useless for cross-compilation, so if you are sure build system allows you to skip them, consider using sparse checkout to exclude them to save storage space.

If the full source code for a package is generated during the release process, you may not be able to use the Git source code directly, in which case you will have to use [URL](https://cmake.org/cmake/help/latest/module/ExternalProject.html#id5) method. Avoid this if possible, as storing archives and unpacked files takes up a lot of storage space.

## After determining how to download, you need to consider which backend build system/build system generator (meta build system) to use.

1. Meson

    - Meson has a standardized, automated pkg-config [generator](https://mesonbuild.com/Pkgconfig-module.html), which usually produces accurate pc files, and also prefers pkg-config as the dependency lookup method, thus avoiding a lot of static linking failures.
    - Meson only supports Ninja as the backend build system, which is the fastest known.
    - Meson has a standardized install script, which makes it easy to exclude useless files from the install target and install only static libraries.
    - Meson is the only build system that always handles cross-compilation correctly.

Above. Meson is the best build system you should choose.

2. CMake

    - CMake is generally not as good as Meson, but it allows you to use cache variables to hack it in a flexible way.
    - CMake has two ways to find dependencies, the CMake module and pkg-config:
        - CMake module usually screws up static linking because it's not standardized and it's too flexible. Most CMake modules don't provide information about private dependencies, which is necessary for static linking.
        - pkg-config is usually good, but CMake always prioritizes modules, and there is no universal way to force pkg-config.
    - CMake supports Ninja, but uses GNU Make by default on UNIX platforms.
    - CMake's install script allows control over what will be installed, but depends on the upstream developers, not the builder, i.e. you, and no default templates are provided.

Above. if upstream doesn't support Meson or screws it up, CMake would be the second choice, it has a lot of shortcomings, but it's perfect compared to the shit below.

3. Autotools (Autoshits)

    - Autoshits' principle dictates that only “In-Source Builds” are supported, which is an extremely serious security risk and a very bad development habit! Do you know how JiaTan broke XZ? This also complicates updating the source code!
    - Autoshits generated “configure” is a shell script, so portability and performance are extremely problematic.
    - if you are lucky enough, the upstream may provide a pre-generated "configure" so you can avoid running Autoshits itself, but it may be outdated.
    - Autoshits only supports GNU Make.
    - Autoshits rarely fails static linking because it only supports pkg-config, which is an unfortunate blessing.

Above. if Meson and CMake are both unsupported, then choose Autoshits. At least it won't screw everything up like a bare Makefile or a niche custom build system.

4. Other build systems
    - There is nothing to say. God bless you.



## After determining which build system to use, you can start customizing the build cmake file.
For meosn/CMake/autoshits, there are templates:

```
ExternalProject_Add(meson-package
    DEPENDS
        package1
    GIT_REPOSITORY https://github.com/a/meson-package.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0" # Delete --sparse if not needed
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !docs !test" # Delete this if --sparse not needed
    GIT_PROGRESS TRUE
    GIT_SUBMODULES "" # Delete this if no submodules
    GIT_CONFIG "submodule.recurse=false" # Delete this if no submodules
    UPDATE_COMMAND "" # We use a customized update method
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup --reconfigure <BINARY_DIR> <SOURCE_DIR>
        ${meson_conf_args}
        -Dfeature_a=disabled
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} meson install -C <BINARY_DIR> --only-changed --tags devel
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(meson-package)
cleanup(meson-package install)
```

```
ExternalProject_Add(cmake-package
    DEPENDS
        package1
    GIT_REPOSITORY https://github.com/a/cmake-package.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0" # Delete --sparse if not needed
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !docs !test" # Delete this if --sparse not needed
    GIT_PROGRESS TRUE
    GIT_SUBMODULES "" # Delete this if no submodules
    GIT_CONFIG "submodule.recurse=false" # Delete this if no submodules
    UPDATE_COMMAND "" # We use a customized update method
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DFEATURE_A=OFF
    BUILD_COMMAND ${EXEC} PACKAGE=${package} BINARY_DIR=<BINARY_DIR> ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(cmake-package)
cleanup(cmake-package install)
```

```
ExternalProject_Add(shit-package
    GIT_REPOSITORY https://github.com/auto/shit.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --filter=tree:0"
    GIT_PROGRESS TRUE
    UPDATE_COMMAND "" # We use a customized update method
    CONFIGURE_COMMAND ${autoreshit}
    COMMAND ${EXEC} CONF=1 ./configure
        ${autoshit_confuck_args}
        --disable-doc
    BUILD_COMMAND ${MAKE} PACKAGE=${package} BINARY_DIR=<BINARY_DIR>
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(shit-package)
cleanup(shit-package install)
```
