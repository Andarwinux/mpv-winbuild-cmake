set_property(DIRECTORY PROPERTY EP_STEP_TARGETS download patch configure build install)
include(${PROJECT_SOURCE_DIR}/cmake/toolchain_check.cmake)
list(APPEND ep
    placeholder
    llvm-wrapper
    mingw-w64
    mingw-w64-headers
    mingw-w64-crt
    mingw-w64-gendef
    cppwinrt
    zlib-host
    libxml2-host
    zstd-host
    mimalloc-host
    ccache
    ninja
    llvm
    #llvm-bolt
    llvm-compiler-rt-builtin
    llvm-host-compiler-rt-builtin
    llvm-libcxx
    llvm-host-libcxx
    llvm-libc
    llvm-compiler-rt
    llvm-host-compiler-rt
    sleef
    llvm-clang
)

foreach(package IN LISTS ep)
    if(NOT ${SINGLE_SOURCE_LOCATION} STREQUAL "")
        set(SOURCE_LOCATION "${SINGLE_SOURCE_LOCATION}/${package}")
    endif()
    if(package MATCHES "llvm")
        cmake_path(RELATIVE_PATH SINGLE_SOURCE_LOCATION BASE_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/toolchain/placeholder-prefix/src/" OUTPUT_VARIABLE PKG_TO_SRC)
        include(${CMAKE_CURRENT_SOURCE_DIR}/llvm/${package}.cmake)
    elseif(package MATCHES "mingw-w64")
        include(${CMAKE_CURRENT_SOURCE_DIR}/mingw-w64/${package}.cmake)
    else()
        include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
    endif()
    set(SOURCE_LOCATION "")
    get_property(_git_repository TARGET ${package} PROPERTY _EP_GIT_REPOSITORY)
    if(_git_repository)
        list(APPEND repo ${package})
    endif()
endforeach()
list(LENGTH ep ep_length)
message(STATUS "Parsing ${ep_length} toolchain packages")
list(TRANSFORM repo APPEND "-force-update" OUTPUT_VARIABLE update)
list(TRANSFORM ep APPEND "-download" OUTPUT_VARIABLE download)
list(TRANSFORM ep APPEND "-fullclean" OUTPUT_VARIABLE fullclean)

add_custom_target(toolchains-update
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${update}
    COMMENT "Updating git repo"
)

add_custom_target(toolchains-download
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${download}
)

add_custom_target(toolchains-fullclean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${fullclean}
    COMMENT "Remove all build and stamp files, reset git HEAD"
)
