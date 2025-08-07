ExternalProject_Add(curl
    DEPENDS
        brotli
        c-ares
        libpsl
        libssh
        ngtcp2
        nghttp2
        nghttp3
        openssl
        zlib
        zstd
    GIT_REPOSITORY https://github.com/curl/curl.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !docs"
    PATCH_COMMAND ${EXEC} git am --3way ${CMAKE_CURRENT_SOURCE_DIR}/curl-*.patch
    UPDATE_COMMAND ""
    CONFIGURE_ENVIRONMENT_MODIFICATION
        _IS_CONFIGURE=set:1
    CONFIGURE_COMMAND ${EXEC} ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
        ${cmake_conf_args}
        -DBUILD_STATIC_LIBS=ON
        -DBUILD_STATIC_CURL=ON
        -DBUILD_LIBCURL_DOCS=OFF
        -DBUILD_EXAMPLES=OFF
        -DBUILD_MISC_DOCS=OFF
        -DCURL_BROTLI=ON
        -DCURL_USE_LIBPSL=ON
        -DCURL_USE_LIBSSH=ON
        -DCURL_USE_LIBSSH2=OFF
        -DCURL_USE_OPENSSL=ON
        -DCURL_ZSTD=ON
        -DENABLE_ARES=ON
        -DENABLE_CURL_MANUAL=OFF
        -DENABLE_UNICODE=ON
        -DENABLE_THREADED_RESOLVER=ON
        -DUSE_NGHTTP2=ON
        -DNGTCP2_VERSION=114514
        -DUSE_NGHTTP3=ON
        -DUSE_NGTCP2=ON
        -DUSE_WIN32_IDN=ON
        -DUSE_WINDOWS_SSPI=ON
        -DUSE_HTTPSRR=ON
        -DUSE_SSLS_EXPORT=ON
        -DCURL_USE_PKGCONFIG=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_Perl=ON
        -DCMAKE_UNITY_BUILD=ON
        -DUNITY_BUILD_BATCH_SIZE=0
        -DCMAKE_UNITY_BUILD_BATCH_SIZE=0
        "-DCMAKE_C_FLAGS='-DNGHTTP3_STATICLIB -DNGHTTP2_STATICLIB -DNGTCP2_STATICLIB -lz -lbrotlienc -lbrotlidec -lbrotlicommon -lzstd -lcrypt32 -lsecur32'"
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/src/curl.exe ${MINGW_INSTALL_PREFIX}/bin/curl.exe
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(curl)
cleanup(curl install)
