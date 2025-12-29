#include <R.h>
#include <Rinternals.h>

// [[export]]
SEXP rolling_average(SEXP x, SEXP window_size) {
  int n = LENGTH(x);
  int w = INTEGER(window_size)[0];
  SEXP result = PROTECT(allocVector(REALSXP, n));
  
  double* px = REAL(x);
  double* pr = REAL(result);
  
  for (int i = 0; i < n; i++) {
    if (i < w / 2 || i > n - w / 2 - 1) {
      pr[i] = NA_REAL; 
    } else {
      double sum = 0.0;
      for (int j = i - w / 2; j <= i + w / 2; j++) {
        sum += px[j];
      }
      pr[i] = sum / w;
    }
  }
  
  UNPROTECT(1);
  return result;
}
