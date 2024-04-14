// This program demonstrates a simple class.
#include <iostream>
using namespace std;

#define PI 3.14
// Circle class declaration.
class Circle {
private:
  double radius;

public:
  void setRadius(double r) { this->radius = r; }
  double getRadius() const { return this->radius; };
  double getDiameter() const { return 2 * this->radius; };
  double getArea() const { return PI * 2 * this->radius; };
};

// setRadius assigns a value to the radius member.

// getRadius assigns a value to the radius member.

// getDiameter

// getArea

int main() {
  Circle c1;        // Define an instance of the Circle class
  double rad, rad1; // Local variable for radius

  // Get the radius from the user.
  cout << "What is the radius? ";
  cin >> rad;
  cin >> rad1;

  if (rad < 0) {
    cout << "Radius must be a positive value" << endl;
    return 0;
  }

  // Store the radius of the circle in the c1 object.
  c1.setRadius(rad);

  // Display the circle's data.
  cout << "\nHere is the circle's data:\n";
  cout << "Radius: " << c1.getRadius() << endl;
  cout << "Diameter: " << c1.getDiameter() << endl;
  cout << "Area: " << c1.getArea() << endl;

  if (rad1 < 0) {
    cout << "Radius must be a positive value" << endl;
    return 0;
  }

  Circle *c2 = new Circle;
  c2->setRadius(rad1);

  // Display the circle's data.
  cout << "\nHere is the circle's data through the pointer:\n";
  cout << "Radius: " << c2->getRadius() << endl;
  cout << "Diameter: " << c2->getDiameter() << endl;
  cout << "Area: " << c2->getArea() << endl;

  return 0;
}
