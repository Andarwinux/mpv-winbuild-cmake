#define SLEEF_STATIC_LIBS
#include <sleef.h>

double acos(double x) { return Sleef_acosd1_u35purecfma(x); }
float  acosf(float x) { return Sleef_acosf1_u35purecfma(x); }

double acosh(double x) { return Sleef_acoshd1_u10purecfma(x); }
float  acoshf(float x) { return Sleef_acoshf1_u10purecfma(x); }

double asin(double x) { return Sleef_asind1_u35purecfma(x); }
float  asinf(float x) { return Sleef_asinf1_u35purecfma(x); }

double asinh(double x) { return Sleef_asinhd1_u10purecfma(x); }
float  asinhf(float x) { return Sleef_asinhf1_u10purecfma(x); }

double atan(double x) { return Sleef_atand1_u35purecfma(x); }
float  atanf(float x) { return Sleef_atanf1_u35purecfma(x); }

double atan2(double y, double x) { return Sleef_atan2d1_u35purecfma(y, x); }
float  atan2f(float y, float x) { return Sleef_atan2f1_u35purecfma(y, x); }

double atanh(double x) { return Sleef_atanhd1_u10purecfma(x); }
float  atanhf(float x) { return Sleef_atanhf1_u10purecfma(x); }

double ceil(double x) { return Sleef_ceild1_purecfma(x); }
float  ceilf(float x) { return Sleef_ceilf1_purecfma(x); }

double floor(double x) { return Sleef_floord1_purecfma(x); }
float  floorf(float x) { return Sleef_floorf1_purecfma(x); }

double rint(double x) { return Sleef_rintd1_purecfma(x); }
float  rintf(float x) { return Sleef_rintf1_purecfma(x); }

double round(double x) { return Sleef_roundd1_purecfma(x); }
float  roundf(float x) { return Sleef_roundf1_purecfma(x); }

double trunc(double x) { return Sleef_truncd1_purecfma(x); }
float  truncf(float x) { return Sleef_truncf1_purecfma(x); }

double copysign(double x, double y) { return Sleef_copysignd1_purecfma(x, y); }
float  copysignf(float x, float y) { return Sleef_copysignf1_purecfma(x, y); }

double cos(double x) { return Sleef_cosd1_u35purecfma(x); }
float  cosf(float x) { return Sleef_cosf1_u35purecfma(x); }

double sin(double x) { return Sleef_sind1_u35purecfma(x); }
float  sinf(float x) { return Sleef_sinf1_u35purecfma(x); }

double tan(double x) { return Sleef_tand1_u35purecfma(x); }
float  tanf(float x) { return Sleef_tanf1_u35purecfma(x); }

double cosh(double x) { return Sleef_coshd1_u35purecfma(x); }
float  coshf(float x) { return Sleef_coshf1_u35purecfma(x); }

double sinh(double x) { return Sleef_sinhd1_u35purecfma(x); }
float  sinhf(float x) { return Sleef_sinhf1_u35purecfma(x); }

double tanh(double x) { return Sleef_tanhd1_u35purecfma(x); }
float  tanhf(float x) { return Sleef_tanhf1_u35purecfma(x); }

double fmod(double x, double y) { return Sleef_fmodd1_purecfma(x, y); }
float  fmodf(float x, float y) { return Sleef_fmodf1_purecfma(x, y); }

double exp(double x) { return Sleef_expd1_u10purecfma(x); }
float  expf(float x) { return Sleef_expf1_u10purecfma(x); }

double exp2(double x) { return Sleef_exp2d1_u35purecfma(x); }
float  exp2f(float x) { return Sleef_exp2f1_u35purecfma(x); }

double expm1(double x) { return Sleef_expm1d1_u10purecfma(x); }
float  expm1f(float x) { return Sleef_expm1f1_u10purecfma(x); }

double log(double x) { return Sleef_logd1_u10purecfma(x); }
float  logf(float x) { return Sleef_logf1_u10purecfma(x); }

double log10(double x) { return Sleef_log10d1_u10purecfma(x); }
float  log10f(float x) { return Sleef_log10f1_u10purecfma(x); }

double log1p(double x) { return Sleef_log1pd1_u10purecfma(x); }
float  log1pf(float x) { return Sleef_log1pf1_u10purecfma(x); }

double log2(double x) { return Sleef_log2d1_u35purecfma(x); }
float  log2f(float x) { return Sleef_log2f1_u35purecfma(x); }

double pow(double x, double y) { return Sleef_powd1_u10purecfma(x, y); }
float  powf(float x, float y) { return Sleef_fastpowf1_u3500purecfma(x, y); }

double sqrt(double x) { return Sleef_sqrtd1_u35purecfma(x); }
float  sqrtf(float x) { return Sleef_sqrtf1_u35purecfma(x); }

double hypot(double x, double y) { return Sleef_hypotd1_u35purecfma(x, y); }
float hypotf(float x, float y) { return Sleef_hypotf1_u35purecfma(x, y); }

int ilogb(double x) { return Sleef_ilogbd1_purecfma(x); }
int ilogbf(float x) { return Sleef_ilogbf(x); }

double ldexp(double x, int exp) { return Sleef_ldexpd1_purecfma(x, exp); }
float ldexpf(float x, int exp) { return Sleef_ldexpf(x, exp); }

double scalbn(double x, int n) { return Sleef_ldexpd1_purecfma(x, n); }
float scalbnf(float x, int n) { return Sleef_ldexpf(x, n); }

long lround(double x) {return (long)(Sleef_truncd1_purecfma(x + (x >= 0 ? 0.5 : -0.5))); }
long lroundf(float x) {return (long)(Sleef_truncf1_purecfma(x + (x >= 0 ? 0.5f : -0.5f))); }

long long llround(double x) { return (long long)(Sleef_truncd1_purecfma(x + (x >= 0 ? 0.5 : -0.5))); }
long long llroundf(float x) { return (long long)(Sleef_truncf1_purecfma(x + (x >= 0 ? 0.5f : -0.5f))); }

double nextafter(double x, double y) { return Sleef_nextafterd1_purecfma(x, y); }
float  nextafterf(float x, float y) { return Sleef_nextafterf1_purecfma(x, y); }

double remainder(double x, double y) {return Sleef_remainderd1_purecfma(x, y); }
float remainderf(float x, float y) {return Sleef_remainderf1_purecfma(x, y); }

double fabs(double x) { return Sleef_fabsd1_purecfma(x); }
float  fabsf(float x) { return Sleef_fabsf1_purecfma(x); }

double erf(double x) { return Sleef_erfd1_u10purecfma(x); }
float  erff(float x) { return Sleef_erff1_u10purecfma(x); }

double cbrt(double x) {return Sleef_cbrtd1_u35purecfma(x); }
float cbrtf(float x) {return Sleef_cbrtf1_u35purecfma(x); }

double frexp(double x, int *exp) {
    *exp = Sleef_expfrexpd1_purecfma(x);
    return Sleef_frfrexpd1_purecfma(x);
}

float frexpf(float x, int *exp) {
    *exp = Sleef_expfrexpf(x);
    return Sleef_frfrexpf1_purecfma(x);
}

double modf(double x, double *iptr) {
    Sleef_double2 r = Sleef_modfd1_purecfma(x);
    *iptr = r.y;
    return r.x;
}

float modff(float x, float *iptr) {
    Sleef_float2 r = Sleef_modff1_purecfma(x);
    *iptr = r.y;
    return r.x;
}

void sincos(double x, double *s, double *c) {
    Sleef_double2 r = Sleef_sincosd1_u35purecfma(x);
    *s = r.x;
    *c = r.y;
}

void sincosf(float x, float *s, float *c) {
    Sleef_float2 r = Sleef_sincosf1_u35purecfma(x);
    *s = r.x;
    *c = r.y;
}
