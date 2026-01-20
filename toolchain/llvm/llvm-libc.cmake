ExternalProject_Add(llvm-libc
    DEPENDS
        mingw-w64-headers
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${LLVM_SRC}
    LIST_SEPARATOR ^^
    CONFIGURE_COMMAND ${EXEC} _IS_CONFIGURE=1 ${CMAKE_COMMAND} -H<SOURCE_DIR>/runtimes -B<BINARY_DIR>
        ${cmake_conf_args}
        -DCMAKE_DISABLE_FIND_PACKAGE_LLVM=ON
        -DCMAKE_DISABLE_FIND_PACKAGE_Clang=ON
        -DLLVM_ENABLE_RUNTIMES='libc'
        -DLLVM_INCLUDE_TESTS=OFF
        -DLIBC_INCLUDE_DOCS=OFF
        -DLIBC_INCLUDE_BENCHMARKS=OFF
        -DLIBC_ENABLE_UNITTESTS=OFF
        -DLIBC_TARGET_TRIPLE=${TARGET_CPU}-pc-windows-gnu
        -DLLVM_ENABLE_WARNINGS=OFF
        -DLIBC_CONF_ENABLE_STRONG_STACK_PROTECTOR=OFF
        -DLIBC_CONF_KEEP_FRAME_POINTER=OFF
        -DLIBC_CONF_ERRNO_MODE=LIBC_ERRNO_MODE_SYSTEM_INLINE
        -DLIBC_ADD_NULL_CHECKS=OFF
        -DLIBC_CONF_MATH_OPTIMIZATIONS=LIBC_MATH_FAST
        -DLIBC_CONF_TIME_64BIT=ON
        -DLIBC_NAMESPACE=__llvm_libc
        -DLIBC_CC_SUPPORTS_NOSTDLIBPP=OFF
        -DLIBC_CC_SUPPORTS_PATTERN_INIT=OFF
        -DLIBC_CONF_STRING_LENGTH_IMPL=arch_vector
        -DLIBC_CONF_FIND_FIRST_CHARACTER_IMPL=word
        ${libc_memcpy_repmovsb}
        -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY
    BUILD_ENVIRONMENT_MODIFICATION
        _PACKAGE_NAME=set:${package}
        _BINARY_DIR=set:<BINARY_DIR>
        _FULL_DEBUGINFO=set:1
        _FORCE_BUILTIN=set:1
        _NOCCACHE=set:1
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR> libc.src.string.memcpy
                                                libc.src.string.memset
                                                libc.src.string.memmove
                                                libc.src.string.memmem
                                                libc.src.string.memchr
                                                libc.src.string.memcmp
                                                libc.src.string.strspn
                                                #libc.src.string.strlen
                                                #libc.src.string.strstr
                                                #libc.src.string.strcpy
                                                libc.src.string.strtok
                                                libc.src.string.strchr
                                                #libc.src.string.strcat
                                                libc.src.string.strcmp
                                                libc.src.string.strrchr
                                                libc.src.string.strcspn
                                                #libc.src.string.strncat
                                                libc.src.string.strncmp
                                                libc.src.string.strncpy
                                                libc.src.string.strnlen
                                                libc.src.string.strpbrk
                                                libc.src.string.strcoll
                                                #libc.src.string.strdup
                                                libc.src.strings.strcasecmp
                                                libc.src.strings.strncasecmp
                                                libc.src.stdlib.qsort
                                                libc.src.stdlib.strtol
                                                libc.src.stdlib.strtold
                                                libc.src.stdlib.strtof
                                                libc.src.stdlib.strtod
                                                libc.src.stdlib.strtoll
                                                libc.src.stdlib.strtoul
                                                libc.src.stdlib.strtoull
                                                libc.src.stdlib.div
                                                libc.src.stdlib.ldiv
                                                libc.src.stdlib.lldiv
                                                libc.src.stdlib.abs
                                                libc.src.stdlib.labs
                                                libc.src.stdlib.llabs
                                                libc.src.stdlib.atof
                                                libc.src.stdlib.atoi
                                                libc.src.stdlib.atol
                                                libc.src.stdlib.atoll
                                                libc.src.stdlib.bsearch
                                                libc.src.stdlib.memalignment
                                                libc.src.inttypes.strtoimax
                                                libc.src.inttypes.strtoumax
                                                libc.src.ctype.isalnum
                                                libc.src.ctype.isalpha
                                                libc.src.ctype.isascii
                                                libc.src.ctype.isblank
                                                libc.src.ctype.iscntrl
                                                libc.src.ctype.isdigit
                                                libc.src.ctype.isgraph
                                                libc.src.ctype.islower
                                                libc.src.ctype.isprint
                                                libc.src.ctype.ispunct
                                                libc.src.ctype.isspace
                                                libc.src.ctype.isupper
                                                libc.src.ctype.isxdigit
                                                libc.src.ctype.toascii
                                                libc.src.ctype.tolower
                                                libc.src.ctype.toupper
    COMMAND ${EXEC} _FORCE_BUILTIN=0 ninja -C <BINARY_DIR> libc.src.string.{strlen,strstr,strcpy,strcat,strncat,strdup}
    COMMAND ${EXEC} ${TARGET_ARCH}-llvm-ar rcs llvmlibc.a libc/src/*/CMakeFiles/libc.src.*.*.dir/*.cpp.obj
    INSTALL_COMMAND ${CMAKE_COMMAND} -E copy llvmlibc.a ${MINGW_INSTALL_PREFIX}/lib/llvmlibc.a
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(llvm-libc install)
