ExternalProject_Add(curl
    DEPENDS
        brotli
        c-ares
        libpsl
        libssh
        nghttp2
        nghttp3
        openssl
        zlib
        zstd
    GIT_REPOSITORY https://github.com/curl/curl.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--depth=1 --no-single-branch --sparse --filter=tree:0"
    GIT_PROGRESS TRUE
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests !docs"
    PATCH_COMMAND ${EXEC} git am --3way ${CMAKE_CURRENT_SOURCE_DIR}/curl-*.patch
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 ${CMAKE_COMMAND} -H<SOURCE_DIR> -B<BINARY_DIR>
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
        -DCURL_DISABLE_TESTS=ON
        -DCURL_ZSTD=ON
        -DENABLE_ARES=ON
        -DENABLE_CURL_MANUAL=OFF
        -DENABLE_UNICODE=ON
        -DENABLE_THREADED_RESOLVER=ON
        -DUSE_NGHTTP2=ON
        -DUSE_NGHTTP3=ON
        -DUSE_OPENSSL_QUIC=ON
        -DUSE_WIN32_IDN=ON
        -DUSE_WINDOWS_SSPI=ON
        -DUSE_ZLIB=ON
        -DUSE_HTTPSRR=ON
        -DUSE_SSLS_EXPORT=ON
        -DCURL_USE_PKGCONFIG=ON
        -DCMAKE_UNITY_BUILD=ON
        -DUNITY_BUILD_BATCH_SIZE=0
        -DCMAKE_UNITY_BUILD_BATCH_SIZE=0
        "-DCMAKE_C_FLAGS='-DNGHTTP3_STATICLIB -DNGHTTP2_STATICLIB'"
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ${CMAKE_COMMAND} --install <BINARY_DIR>
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(curl)
cleanup(curl install)
