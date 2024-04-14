#include "Complex.h"
#include <sstream>
/* class Complex {
private:
  double real, imaginary;

public:
  Complex(double rreal = 0, double imag = 0);
  Complex(string input);

  double getReal();
  double getImaginary();
  void setReal(double rreal);
  void setImaginary(double imag);

  // c = a + b;  instead of  c = a.add(b);
  Complex operator+(const Complex &second) const;
  // a += b;
  void operator+=(const Complex &second);
  Complex operator~();

  // friend functions
  friend istream &operator>>(istream &input, Complex &object);
  friend ostream &operator<<(ostream &output, const Complex &object);
};

#endif // COMPLEX_H */
Complex::Complex(double rreal, double imag) : real(rreal), imaginary(imag) {}
Complex::Complex(string input) {
  istringstream stream(input);
  stream >> real >> imaginary;
}

double Complex::getReal() { return real; }
double Complex::getImaginary() { return imaginary; }
void Complex::setReal(double rreal) { real = rreal; }
void Complex::setImaginary(double imag) { imaginary = imag; }

// c = a + b;  instead of  c = a.add(b);
Complex Complex::operator+(const Complex &second) const {
  return Complex(real + second.real, imaginary + second.imaginary);
}
// a += b;
void Complex::operator+=(const Complex &second) {
  real += second.real;
  imaginary += second.imaginary;
}
Complex Complex::operator~() { return Complex(real, -imaginary); }

istream &operator>>(istream &input, Complex &object) {
  input >> object.real >> object.imaginary;
  return input;
}
ostream &operator<<(ostream &output, const Complex &object) {
  output << "(" << object.real << ',' << object.imaginary << ")";
  return output;
}
