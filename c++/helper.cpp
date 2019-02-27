#include <iostream>
using namespace std;

typedef double (*function_type)(double, void*);

typedef struct {
  double a;
  double b;
} f_data;

double f(double x, double a, double b) {
  return a*x*x + b;
}

double f_helper(double x, void* work)
{
  f_data * data = (f_data *) work; // C++
  // f_data *data = work; // C

  return f(x, data->a, data->b);
}

double calc_f(function_type fx, void *work) {
  double result, x = -9.0;

  f_data *data = (f_data *)work;

  result = fx(x, work);

  return result;
}

int main() {

  f_data params;
  params.a = 1;
  params.b = 2;

  double result = calc_f(f_helper, &params);

  printf ("result: %4.2f \n", result);

  return 0;
}
