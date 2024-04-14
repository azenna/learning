#ifndef RECTANGLEFROMGO_H
#define RECTANGLEFROMGO_H
#include "GeometricObject.h"
#include <iostream>

class RectangleFromGO : public GeometricObject {
private:
  double width, height;

public:
  RectangleFromGO();
  RectangleFromGO(double w, double h);
  RectangleFromGO(double w, double h, string col, bool fil);

  double getWidth() const;
  double getHeight() const;

  void setWidth(double w);
  void setHeight(double h);

  double getArea() const;
  double getPerimeter() const;

  friend ostream &operator<<(ostream &strm, const RectangleFromGO &obj);

  void print();
};

#endif
