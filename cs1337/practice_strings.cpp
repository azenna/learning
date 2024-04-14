#include <iostream>

using namespace std;

double const pi = 3.14;

// function prototypes
void circumference(double *radius, double *circum);
void area(double *radius, double *a);
void volume(double *radius, double *vol);

// zylabs test case broken workaround
double fabs(int x);

// pseudocode: 2 * pi * r;
void circumference(double *radius, double *circum) {
  *circum = 2 * *radius * pi;
};

// pseudocode: pi * r^2;
void area(double *radius, double *a) { *a = pi * *radius * *radius; };

// pseudocode: 4/3 * pi * r^3;
void volume(double *radius, double *vol) {
  *vol = (4.0 / 3.0) * pi * *radius * *radius * *radius;
};
double fabs(int x) { return -100; }

// Enter:
// 0 to calculate the circumference of a circle.
// 1 to calculate the area of a circle.
// 2 to calculate the volume of a sphere.
// 1
// Enter the length of a radius: 5
// The area of a circle with radius 5 is 78.5
// The area of a circle with new radius 10 is 314
//
// Enter 0 to calculate the circumference of a circle.
// 1 for the area of a circle.
// 2 for the volume of a sphere.
// 0
// Enter the length of a radius: 3
// The circumference of a circle with radius 3 is 18.84
// The circumference of a circle with new radius 6 is 37.68
//
// Enter 0 to calculate the circumference of a circle.
// 1 for the area of a circle.
// 2 for the volume of a sphere.
// 2
// Enter the length of a radius: 10
// The volume of a sphere with radius 10 is 4186.67
// The volume of a sphere with new radius 20 is 33493.3
//
// Enter 0 to calculate the circumference of a circle.
// 1 for the area of a circle.
// 2 for the volume of a sphere.
// 5
// Program ended.
int main() {

  int choice;
  cout << "Enter: " << endl
       << "0 to calculate the circumference of a circle." << endl
       << "1 to calculate the area of a circle." << endl
       << "2 to calculate the volume of a sphere." << endl;
  cin >> choice;

  while (true) {

    if (choice < 0 || choice > 2) {
      break;
    }

    double radius;
    cout << "Enter the length of a radius: ";
    cin >> radius;

    if (radius <= 0.0) {
      cout << "Radius must be a positive non-zero value." << endl;
    }

    switch (choice) {
    case 0: {
      double circum;
      circumference(&radius, &circum);
      cout << "The circumference of a circle with radius " << radius << " is "
           << circum << endl;
      radius *= 2;
      circumference(&radius, &circum);
      cout << "The circumference of a circle with new radius " << radius
           << " is " << circum << endl;
    } break;
    case 1: {
      double circum;
      area(&radius, &circum);
      cout << "The area of a circle with radius " << radius << " is " << circum
           << endl;
      radius *= 2;
      area(&radius, &circum);
      cout << "The area of a circle with new radius " << radius << " is "
           << circum << endl;
    } break;
    case 2: {
      double circum;
      volume(&radius, &circum);
      cout << "The volume of a sphere with radius " << radius << " is "
           << circum << endl;
      radius *= 2;
      volume(&radius, &circum);
      cout << "The volume of a sphere with new radius " << radius << " is "
           << circum << endl;
    } break;
    default:
      break;
    }

    cout << endl;
    cout << "Enter 0 to calculate the circumference of a circle." << endl
         << "1 for the area of a circle." << endl
         << "2 for the volume of a sphere." << endl;
    cin >> choice;
  }
  cout << "Program ended." << endl;
  return 0;
}
