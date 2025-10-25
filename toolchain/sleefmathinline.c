#include <stdint.h>
#include <stddef.h>
#include <sleefinline_purecfma_scalar.h>

__attribute__((always_inline)) double acos(double x) { return Sleef_acosd1_u35purecfma(x); }
__attribute__((always_inline)) float  acosf(float x) { return Sleef_acosf1_u35purecfma(x); }

__attribute__((always_inline)) double acosh(double x) { return Sleef_acoshd1_u10purecfma(x); }
__attribute__((always_inline)) float  acoshf(float x) { return Sleef_acoshf1_u10purecfma(x); }

__attribute__((always_inline)) double asin(double x) { return Sleef_asind1_u35purecfma(x); }
__attribute__((always_inline)) float  asinf(float x) { return Sleef_asinf1_u35purecfma(x); }

__attribute__((always_inline)) double asinh(double x) { return Sleef_asinhd1_u10purecfma(x); }
__attribute__((always_inline)) float  asinhf(float x) { return Sleef_asinhf1_u10purecfma(x); }

__attribute__((always_inline)) double atan(double x) { return Sleef_atand1_u35purecfma(x); }
__attribute__((always_inline)) float  atanf(float x) { return Sleef_atanf1_u35purecfma(x); }

__attribute__((always_inline)) double atan2(double y, double x) { return Sleef_atan2d1_u35purecfma(y, x); }
__attribute__((always_inline)) float  atan2f(float y, float x) { return Sleef_atan2f1_u35purecfma(y, x); }

__attribute__((always_inline)) double atanh(double x) { return Sleef_atanhd1_u10purecfma(x); }
__attribute__((always_inline)) float  atanhf(float x) { return Sleef_atanhf1_u10purecfma(x); }

__attribute__((always_inline)) double ceil(double x) { return Sleef_ceild1_purecfma(x); }
__attribute__((always_inline)) float  ceilf(float x) { return Sleef_ceilf1_purecfma(x); }

__attribute__((always_inline)) double floor(double x) { return Sleef_floord1_purecfma(x); }
__attribute__((always_inline)) float  floorf(float x) { return Sleef_floorf1_purecfma(x); }

__attribute__((always_inline)) double rint(double x) { return Sleef_rintd1_purecfma(x); }
__attribute__((always_inline)) float  rintf(float x) { return Sleef_rintf1_purecfma(x); }

__attribute__((always_inline)) double round(double x) { return Sleef_roundd1_purecfma(x); }
__attribute__((always_inline)) float  roundf(float x) { return Sleef_roundf1_purecfma(x); }

__attribute__((always_inline)) double trunc(double x) { return Sleef_truncd1_purecfma(x); }
__attribute__((always_inline)) float  truncf(float x) { return Sleef_truncf1_purecfma(x); }

__attribute__((always_inline)) double copysign(double x, double y) { return Sleef_copysignd1_purecfma(x, y); }
__attribute__((always_inline)) float  copysignf(float x, float y) { return Sleef_copysignf1_purecfma(x, y); }

__attribute__((always_inline)) double cos(double x) { return Sleef_cosd1_u35purecfma(x); }
__attribute__((always_inline)) float  cosf(float x) { return Sleef_cosf1_u35purecfma(x); }

__attribute__((always_inline)) double sin(double x) { return Sleef_sind1_u35purecfma(x); }
__attribute__((always_inline)) float  sinf(float x) { return Sleef_sinf1_u35purecfma(x); }

__attribute__((always_inline)) double tan(double x) { return Sleef_tand1_u35purecfma(x); }
__attribute__((always_inline)) float  tanf(float x) { return Sleef_tanf1_u35purecfma(x); }

__attribute__((always_inline)) double cosh(double x) { return Sleef_coshd1_u35purecfma(x); }
__attribute__((always_inline)) float  coshf(float x) { return Sleef_coshf1_u35purecfma(x); }

__attribute__((always_inline)) double sinh(double x) { return Sleef_sinhd1_u35purecfma(x); }
__attribute__((always_inline)) float  sinhf(float x) { return Sleef_sinhf1_u35purecfma(x); }

__attribute__((always_inline)) double tanh(double x) { return Sleef_tanhd1_u35purecfma(x); }
__attribute__((always_inline)) float  tanhf(float x) { return Sleef_tanhf1_u35purecfma(x); }

__attribute__((always_inline)) double fmod(double x, double y) { return Sleef_fmodd1_purecfma(x, y); }
__attribute__((always_inline)) float  fmodf(float x, float y) { return Sleef_fmodf1_purecfma(x, y); }

__attribute__((always_inline)) double pow(double x, double y) { return Sleef_powd1_u10purecfma(x, y); }
__attribute__((always_inline)) float  powf(float x, float y) { return Sleef_fastpowf1_u3500purecfma(x, y); }

__attribute__((always_inline)) double exp(double x) { return Sleef_expd1_u10purecfma(x); }
__attribute__((always_inline)) float  expf(float x) { return Sleef_expf1_u10purecfma(x); }

__attribute__((always_inline)) double exp2(double x) { return Sleef_exp2d1_u35purecfma(x); }
__attribute__((always_inline)) float  exp2f(float x) { return Sleef_exp2f1_u35purecfma(x); }

__attribute__((always_inline)) double expm1(double x) { return Sleef_expm1d1_u10purecfma(x); }
__attribute__((always_inline)) float  expm1f(float x) { return Sleef_expm1f1_u10purecfma(x); }

__attribute__((always_inline)) double log(double x) { return Sleef_logd1_u10purecfma(x); }
__attribute__((always_inline)) float  logf(float x) { return Sleef_logf1_u10purecfma(x); }

__attribute__((always_inline)) double log10(double x) { return Sleef_log10d1_u10purecfma(x); }
__attribute__((always_inline)) float  log10f(float x) { return Sleef_log10f1_u10purecfma(x); }

__attribute__((always_inline)) double log1p(double x) { return Sleef_log1pd1_u10purecfma(x); }
__attribute__((always_inline)) float  log1pf(float x) { return Sleef_log1pf1_u10purecfma(x); }

__attribute__((always_inline)) double log2(double x) { return Sleef_log2d1_u35purecfma(x); }
__attribute__((always_inline)) float  log2f(float x) { return Sleef_log2f1_u35purecfma(x); }

__attribute__((always_inline)) double sqrt(double x) { return Sleef_sqrtd1_u35purecfma(x); }
__attribute__((always_inline)) float  sqrtf(float x) { return Sleef_sqrtf1_u35purecfma(x); }

__attribute__((always_inline)) double hypot(double x, double y) { return Sleef_hypotd1_u35purecfma(x, y); }
__attribute__((always_inline)) float  hypotf(float x, float y) { return Sleef_hypotf1_u35purecfma(x, y); }

__attribute__((always_inline)) long lround(double x) {return (long)(Sleef_truncd1_purecfma(x + (x >= 0 ? 0.5 : -0.5))); }
__attribute__((always_inline)) long lroundf(float x) {return (long)(Sleef_truncf1_purecfma(x + (x >= 0 ? 0.5f : -0.5f))); }

__attribute__((always_inline)) long long llround(double x) { return (long long)(Sleef_truncd1_purecfma(x + (x >= 0 ? 0.5 : -0.5))); }
__attribute__((always_inline)) long long llroundf(float x) { return (long long)(Sleef_truncf1_purecfma(x + (x >= 0 ? 0.5f : -0.5f))); }

__attribute__((always_inline)) double nextafter(double x, double y) { return Sleef_nextafterd1_purecfma(x, y); }
__attribute__((always_inline)) float  nextafterf(float x, float y) { return Sleef_nextafterf1_purecfma(x, y); }

__attribute__((always_inline)) double remainder(double x, double y) {return Sleef_remainderd1_purecfma(x, y); }
__attribute__((always_inline)) float  remainderf(float x, float y) {return Sleef_remainderf1_purecfma(x, y); }

__attribute__((always_inline)) double fabs(double x) { return Sleef_fabsd1_purecfma(x); }
__attribute__((always_inline)) float  fabsf(float x) { return Sleef_fabsf1_purecfma(x); }

__attribute__((always_inline)) double erf(double x) { return Sleef_erfd1_u10purecfma(x); }
__attribute__((always_inline)) float  erff(float x) { return Sleef_erff1_u10purecfma(x); }

__attribute__((always_inline)) double cbrt(double x) {return Sleef_cbrtd1_u35purecfma(x); }
__attribute__((always_inline)) float  cbrtf(float x) {return Sleef_cbrtf1_u35purecfma(x); }

__attribute__((always_inline)) void sincos(double x, double *s, double *c) {
    vdouble2_purecfma_scalar_sleef r = Sleef_sincosd1_u35purecfma(x);
    *s = r.x;
    *c = r.y;
}

__attribute__((always_inline)) void sincosf(float x, float *s, float *c) {
    vfloat2_purecfma_scalar_sleef r = Sleef_sincosf1_u35purecfma(x);
    *s = r.x;
    *c = r.y;
}
