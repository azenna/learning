#ifndef COMPLEX_H
#define COMPLEX_H

#include <cstdlib>
#include <fstream>
#include <iostream>
#include <sstream>
#include <string>

using namespace std;

class Complex {
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

#endif // COMPLEX_H
