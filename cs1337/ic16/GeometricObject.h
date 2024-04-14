#ifndef GEOMETRICOBJECT_H
#define GEOMETRICOBJECT_H
#include <iostream>
#include <string>
using namespace std;

class GeometricObject {
private:
  string color;
  bool filled;

public:
  GeometricObject() : color("white"), filled(true) {}
  GeometricObject(string col, bool fil) : color(col), filled(fil) {}
  string getColor() const { return color; }
  bool getFilled() const { return filled; }
  void setColor(string col) { color = col; }
  void setFilled(bool fil) { filled = fil; }
  void printGO() {
    cout << "Color: " << color << " and filled: " << int(filled) << endl;
  };
};
#endif
