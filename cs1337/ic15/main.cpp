#include "Complex.h"
#include <iostream>

using namespace std;

int main() {

  double real, imaginary;
  cout << "Enter real and imaginary values: ";
  cin >> real >> imaginary;

  Complex c1, c2;
  c1.setReal(real);
  c1.setImaginary(imaginary);

  // taking this input as complex object
  cout << "Enter another real and imaginary values: ";
  cin >> c2; // >> operator overloading on Complex

  // Complex c3 = c1.add(c2);
  Complex c3 = c1 + c2; // = operator overloading!

  cout << "The real and imaginary values of  c3: ";
  cout << c3 << endl; // << operator overloading!

  c3 += Complex(
      "1.9 10.01"); // create a temporary object from a string and add it to c3
  /* Same effect as following 2 lines:
     Complex c4("1.9 10.01");
  c3 += c4;
  */
  cout << "The real and imaginary values of  c3 after new complex number is "
          "added to it: ";
  cout << c3 << endl;

  cout << "The conjugate of c3 assigned to c4 is : ";
  Complex c4 = ~c3;   //(a, b) -> (a, -b)
  cout << c4 << endl; //~ operator should return conjugate of complex number:
                      //(a,b) --> (a,-b)

  // So far, we created objects as local variables, we can use dynamic memory
  // too, using pointers.
  Complex *c5p = new Complex(11.11, 22.22);

  cout << "The values of pointer variable c5: ";
  cout << c5p->getReal() << " " << c5p->getImaginary() << endl;
  // it is common practice to use get methods are used to access private
  // variables.
  cout << "The real and imaginary part added : ";
  cout << c5p->getReal() + c5p->getImaginary() << endl;

  cout << "The values of variable c6 after adding two numbers : ";
  Complex c6 = Complex(1, 2) + Complex("3 4");
  cout << c6 << endl;
  // cout << Complex(1, 2) + Complex("3 4") + Complex()<< endl;

  cout << "The values of variable c6 after adding one number to itself: ";
  c6 += Complex(4, 7);
  cout << c6 << endl << endl;
}
