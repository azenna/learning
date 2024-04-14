/*
A  program to input a value.  Assign a pointer to point to the value. If the
input is not positive, make the Pointer point to a null value. If not multiply
the value to which the Pointer points to by 100. Ex: If the user enters 9, the
output should be: Values: 900 If the user enters -9, the output should be: -9 is
not a positive number
*/

#include <iostream>
using namespace std;

int main() {

  /* Your solution goes here
  I have some outputs to match the run tests
  */

  // declarations of variables and pointers
  int val;

  cout << "Enter a value: ";
  cin >> val;

  int* ptr_val = &val;

  if(val < 0){
      ptr_val = NULL;
  }

  // calculations of the values if it is a positive number
  if (ptr_val ==  NULL) {
    cout << val << " is not a positive number" << endl;
  } else {
    cout << "Value: " << val * 100 << endl;
  }
}
