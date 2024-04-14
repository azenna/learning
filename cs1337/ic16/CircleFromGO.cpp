#include "CircleFromGO.h"
#include "GeometricObject.h"

using namespace std;

CircleFromGO::CircleFromGO() : GeometricObject(), radius(0.0) {}
CircleFromGO::CircleFromGO(double rad) : GeometricObject(), radius(rad) {}
CircleFromGO::CircleFromGO(double rad, string col, bool fil)
    : GeometricObject(col, fil), radius(rad) {}

double CircleFromGO::getRadius() const { return radius; }
void CircleFromGO::setRadius(double rad) { radius = rad; }

double CircleFromGO::getArea() const { return M_PI * radius * radius; }
double CircleFromGO::getPerimeter() const { return M_PI * 2 * radius; }
double CircleFromGO::getDiameter() const { return 2 * radius; }

ostream &operator<<(ostream &strm, const CircleFromGO &obj) {
  cout << "The circle printed with ostream!" << endl;
  cout << "The radius is " << obj.getRadius() << endl;
  cout << "Color: " << obj.getColor() << " and Area: " << obj.getArea() << endl;
  return strm;
}

void CircleFromGO::print() {
  cout << "The circle is created and the radius is " << radius << endl;
  this->printGO();
}
