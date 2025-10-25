#define SLEEF_STATIC_LIBS
#include <sleef.h>

__attribute__((always_inline)) int ilogb(double x) { return Sleef_ilogbd1_purecfma(x); }
__attribute__((always_inline)) int ilogbf(float x) { return Sleef_ilogbf(x); }

__attribute__((always_inline)) double scalbn(double x, int n) { return Sleef_ldexpd1_purecfma(x, n); }
__attribute__((always_inline)) float scalbnf(float x, int n) { return Sleef_ldexpf(x, n); }


__attribute__((always_inline)) double ldexp(double x, int exp) { return Sleef_ldexpd1_purecfma(x, exp); }
__attribute__((always_inline)) float ldexpf(float x, int exp) { return Sleef_ldexpf(x, exp); }

__attribute__((always_inline)) double frexp(double x, int *exp) {
    *exp = Sleef_expfrexpd1_purecfma(x);
    return Sleef_frfrexpd1_purecfma(x);
}

__attribute__((always_inline)) float frexpf(float x, int *exp) {
    *exp = Sleef_expfrexpf(x);
    return Sleef_frfrexpf1_purecfma(x);
}

__attribute__((always_inline)) double modf(double x, double *iptr) {
    Sleef_double2 r = Sleef_modfd1_purecfma(x);
    *iptr = r.y;
    return r.x;
}

__attribute__((always_inline)) float modff(float x, float *iptr) {
    Sleef_float2 r = Sleef_modff1_purecfma(x);
    *iptr = r.y;
    return r.x;
}
