#ifndef CIRCLEFROMGO_H
#define CIRCLEFROMGO_H
#include "GeometricObject.h"
#include <math.h>

class CircleFromGO : public GeometricObject {
private:
  double radius;

public:
  CircleFromGO();
  CircleFromGO(double rad);
  CircleFromGO(double rad, string col, bool fil);

  double getRadius() const;
  void setRadius(double rad);

  double getArea() const;
  double getPerimeter() const;
  double getDiameter() const;

  void print();

  friend ostream &operator<<(ostream &strm, const CircleFromGO &obj);
};
#endif
