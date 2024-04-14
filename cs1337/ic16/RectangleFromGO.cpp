#include "RectangleFromGO.h"
#include "GeometricObject.h"

RectangleFromGO::RectangleFromGO()
    : GeometricObject(), width(0.0), height(0.0) {}

RectangleFromGO::RectangleFromGO(double w, double h)
    : GeometricObject(), width(w), height(h) {}

RectangleFromGO::RectangleFromGO(double w, double h, string col, bool fil)
    : GeometricObject(col, fil), width(w), height(h) {}

double RectangleFromGO::getWidth() const { return width; }
double RectangleFromGO::getHeight() const { return height; }

void RectangleFromGO::setWidth(double w) { width = w; }
void RectangleFromGO::setHeight(double h) { height = h; }

double RectangleFromGO::getArea() const { return width * height; }
double RectangleFromGO::getPerimeter() const { return 2 * width + 2 * height; }

ostream &operator<<(ostream &strm, const RectangleFromGO &obj) {
  cout << "The Rectangle printed with ostream!" << endl;
  cout << "The width and height is " << obj.getWidth() << ", "
       << obj.getHeight() << endl;
  cout << "Color: " << obj.getColor() << " and Area: " << obj.getArea() << endl;
  return strm;
}

void RectangleFromGO::print() {
  cout << "The rectangle width is " << width << " and the height is " << height
       << endl;
  this->printGO();
}
