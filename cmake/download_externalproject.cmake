set(version "master")

file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake)

if(NOT EXISTS "${CMAKE_CURRENT_BINARY_DIR}/modules.tar.gz")
    file(DOWNLOAD https://gitlab.kitware.com/cmake/cmake/-/archive/${version}/cmake-${version}.tar.gz?path=Modules/ExternalProject ${CMAKE_CURRENT_BINARY_DIR}/modules.tar.gz TLS_VERSION 1.3)
    execute_process(
        COMMAND tar -C ${CMAKE_CURRENT_BINARY_DIR}/cmake --strip-components=1 -xf modules.tar.gz
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        COMMAND_ERROR_IS_FATAL ANY
    )
endif()

if(NOT EXISTS "${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject.cmake")
    file(DOWNLOAD https://gitlab.kitware.com/cmake/cmake/-/raw/${version}/Modules/ExternalProject.cmake ${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject.cmake TLS_VERSION 1.3)
    execute_process(
        COMMAND patch -p1 -i ${CMAKE_CURRENT_SOURCE_DIR}/packages/cmake-0001-ExternalProject-changes.patch
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/cmake
        COMMAND_ERROR_IS_FATAL ANY
    )
endif()

include(${CMAKE_CURRENT_BINARY_DIR}/cmake/Modules/ExternalProject.cmake)
