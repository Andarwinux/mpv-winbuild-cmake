#include <stdint.h>
#include <stddef.h>
#include <sleefinline_purecfma_scalar.h>

__attribute__((noinline,hot))                    double    acos(double x){return Sleef_acosd1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    acosh(double x){return Sleef_acoshd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    asin(double x){return Sleef_asind1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    asinh(double x){return Sleef_asinhd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    atan(double x){return Sleef_atand1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    atan2(double y, double x){return Sleef_atan2d1_u35purecfma(y, x);}
__attribute__((noinline,hot))                    double    atanh(double x){return Sleef_atanhd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    cbrt(double x){return Sleef_cbrtd1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    ceil(double x){return __builtin_ceil(x);}
__attribute__((noinline,hot))                    double    copysign(double x, double y){return __builtin_copysign(x, y);}
__attribute__((noinline,hot))                    double    cos(double x){return Sleef_cosd1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    cosh(double x){return Sleef_coshd1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    erf(double x){return Sleef_erfd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    exp(double x){return Sleef_expd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    exp2(double x){return Sleef_exp2d1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    expm1(double x){return Sleef_expm1d1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    fabs(double x){return __builtin_fabs(x);}
__attribute__((noinline,hot))                    double    floor(double x){return __builtin_floor(x);}
__attribute__((noinline,hot))                    double    fmod(double x, double y){return Sleef_fmodd1_purecfma(x, y);}
__attribute__((noinline,hot))                    double    frexp(double x, int *exp){return (*exp = Sleef_expfrexpd1_purecfma(x), Sleef_frfrexpd1_purecfma(x));}
__attribute__((noinline,hot))                    double    hypot(double x, double y){return Sleef_hypotd1_u35purecfma(x, y);}
                                                 #ifdef     __ARM_FEATURE_SVE
__attribute__((noinline,hot))                    double    ldexp(double x, int exp){return __builtin_ldexp(x, exp);}
                                                 #else
__attribute__((noinline,hot))                    double    ldexp(double x, int exp){return Sleef_ldexpd1_purecfma(x, exp);}
                                                 #endif
__attribute__((noinline,hot))                    double    log(double x){return Sleef_logd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    log10(double x){return Sleef_log10d1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    log1p(double x){return Sleef_log1pd1_u10purecfma(x);}
__attribute__((noinline,hot))                    double    log2(double x){return Sleef_log2d1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    modf(double x, double *iptr){vdouble2_purecfma_scalar_sleef r = Sleef_modfd1_purecfma(x);return (*iptr = r.y, r.x);}
__attribute__((noinline,hot))                    double    nextafter(double x, double y){return Sleef_nextafterd1_purecfma(x, y);}
__attribute__((noinline,hot))                    double    pow(double x, double y){return Sleef_powd1_u10purecfma(x, y);}
__attribute__((noinline,hot))                    double    remainder(double x, double y){return Sleef_remainderd1_purecfma(x, y);}
__attribute__((noinline,hot))                    double    rint(double x){return __builtin_rint(x);}
__attribute__((noinline,hot))                    double    round(double x){return __builtin_round(x);}
                                                 #ifdef     __ARM_FEATURE_SVE
__attribute__((noinline,hot))                    double    scalbn(double x, int n){return __builtin_ldexp(x, n);}
                                                 #else
__attribute__((noinline,hot))                    double    scalbn(double x, int n){return Sleef_ldexpd1_purecfma(x, n);}
                                                 #endif
__attribute__((noinline,hot))                    double    sin(double x){return Sleef_sind1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    sinh(double x){return Sleef_sinhd1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    sqrt(double x){return __builtin_sqrt(x);}
__attribute__((noinline,hot))                    double    tan(double x){return Sleef_tand1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    tanh(double x){return Sleef_tanhd1_u35purecfma(x);}
__attribute__((noinline,hot))                    double    trunc(double x){return __builtin_trunc(x);}

__attribute__((noinline,hot))                    float     acosf(float x){return Sleef_acosf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     acoshf(float x){return Sleef_acoshf1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     asinf(float x){return Sleef_asinf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     asinhf(float x){return Sleef_asinhf1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     atan2f(float y, float x){return Sleef_atan2f1_u35purecfma(y, x);}
__attribute__((noinline,hot))                    float     atanf(float x){return Sleef_atanf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     atanhf(float x){return Sleef_atanhf1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     cbrtf(float x){return Sleef_cbrtf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     ceilf(float x){return __builtin_ceilf(x);}
__attribute__((noinline,hot))                    float     copysignf(float x, float y){return __builtin_copysignf(x, y);}
__attribute__((noinline,hot))                    float     cosf(float x){return Sleef_cosf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     coshf(float x){return Sleef_coshf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     erff(float x){return Sleef_erff1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     exp2f(float x){return Sleef_exp2f1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     expf(float x){return Sleef_expf1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     expm1f(float x){return Sleef_expm1f1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     fabsf(float x){return __builtin_fabsf(x);}
__attribute__((noinline,hot))                    float     floorf(float x){return __builtin_floorf(x);}
__attribute__((noinline,hot))                    float     fmodf(float x, float y){return Sleef_fmodf1_purecfma(x, y);}
__attribute__((noinline,hot))                    float     frexpf(float x, int *exp){return (*exp = Sleef_expfrexpf1_purecfma(x), Sleef_frfrexpf1_purecfma(x));}
__attribute__((noinline,hot))                    float     hypotf(float x, float y){return Sleef_hypotf1_u35purecfma(x, y);}
                                                 #ifdef     __ARM_FEATURE_SVE
__attribute__((noinline,hot))                    float     ldexpf(float x, int exp){return __builtin_ldexpf(x, exp);}
                                                 #else
__attribute__((noinline,hot))                    float     ldexpf(float x, int exp){return Sleef_ldexpf1_purecfma(x, exp);}
                                                 #endif
__attribute__((noinline,hot))                    float     log10f(float x){return Sleef_log10f1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     log1pf(float x){return Sleef_log1pf1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     log2f(float x){return Sleef_log2f1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     logf(float x){return Sleef_logf1_u10purecfma(x);}
__attribute__((noinline,hot))                    float     modff(float x, float *iptr){vfloat2_purecfma_scalar_sleef r = Sleef_modff1_purecfma(x); return (*iptr = r.y, r.x);}
__attribute__((noinline,hot))                    float     nextafterf(float x, float y){return Sleef_nextafterf1_purecfma(x, y);}
__attribute__((noinline,hot))                    float     powf(float x, float y){return Sleef_fastpowf1_u3500purecfma(x, y);}
__attribute__((noinline,hot))                    float     remainderf(float x, float y){return Sleef_remainderf1_purecfma(x, y);}
__attribute__((noinline,hot))                    float     rintf(float x){return __builtin_rintf(x);}
__attribute__((noinline,hot))                    float     roundf(float x){return __builtin_roundf(x);}
                                                 #ifdef     __ARM_FEATURE_SVE
__attribute__((noinline,hot))                    float     scalbnf(float x, int n){return __builtin_ldexpf(x, n);}
                                                 #else
__attribute__((noinline,hot))                    float     scalbnf(float x, int n){return Sleef_ldexpf1_purecfma(x, n);}
                                                 #endif
__attribute__((noinline,hot))                    float     sinf(float x){return Sleef_sinf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     sinhf(float x){return Sleef_sinhf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     sqrtf(float x){return __builtin_sqrtf(x);}
__attribute__((noinline,hot))                    float     tanf(float x){return Sleef_tanf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     tanhf(float x){return Sleef_tanhf1_u35purecfma(x);}
__attribute__((noinline,hot))                    float     truncf(float x){return __builtin_truncf(x);}

__attribute__((noinline,hot))                    int       ilogb(double x){return Sleef_ilogbd1_purecfma(x);}
__attribute__((noinline,hot))                    int       ilogbf(float x){return Sleef_ilogbf1_purecfma(x);}

__attribute__((noinline,hot))                    long      lround(double x){return (long)(__builtin_round(x));}
__attribute__((noinline,hot))                    long      lroundf(float x){return (long)(__builtin_roundf(x));}

__attribute__((noinline,hot))                    long long llround(double x){return (long long)(__builtin_round(x));}
__attribute__((noinline,hot))                    long long llroundf(float x){return (long long)(__builtin_roundf(x));}

__attribute__((always_inline,hot))               void      sincos(double x, double *s, double *c){vdouble2_purecfma_scalar_sleef r = Sleef_sincosd1_u35purecfma(x); *s = r.x; *c = r.y;}
__attribute__((always_inline,hot))               void      sincosf(float x, float *s, float *c){vfloat2_purecfma_scalar_sleef r = Sleef_sincosf1_u35purecfma(x); *s = r.x; *c = r.y;}
