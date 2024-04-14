#include "CircleFromGO.h"
#include "RectangleFromGO.h"
#include <iostream>
using namespace std;

int main() {
  CircleFromGO circle(5.3, "Blue", true);
  circle.print();
  cout << "The color is " << circle.getColor() << endl;
  cout << "The color filled is " << circle.getFilled() << endl;
  cout << "The radius is " << circle.getRadius() << endl;
  cout << "The area is " << circle.getArea() << endl;
  cout << "The diameter is " << circle.getDiameter() << endl;
  cout << circle << endl << endl;

  CircleFromGO circle2(15.3);
  circle2.print();
  cout << "The color is " << circle2.getColor() << endl;
  cout << "The color filled is " << circle2.getFilled() << endl;
  circle2.setColor("Green");
  cout << "After setting, the color is " << circle2.getColor() << endl;
  cout << "The radius is " << circle2.getRadius() << endl;
  cout << "The area is " << circle2.getArea() << endl;
  cout << "The diameter is " << circle2.getDiameter() << endl;
  cout << circle2 << endl << endl;

  CircleFromGO circle3;
  circle3.print();
  cout << "The color is " << circle3.getColor() << endl;
  cout << "The color filled is " << circle3.getFilled() << endl;
  cout << "The radius is " << circle3.getRadius() << endl;
  cout << "The area is " << circle3.getArea() << endl;
  cout << "The diameter is " << circle3.getDiameter() << endl;
  circle3.setRadius(26.7);
  circle3.setColor("Yellow");
  cout << circle3 << endl << endl;

  RectangleFromGO rect1(27.9, 15.6, "Red", false);
  rect1.print();
  cout << "The color is " << rect1.getColor() << endl;
  cout << "The color filled is " << rect1.getFilled() << endl;
  cout << "The width is " << rect1.getWidth() << endl;
  cout << "The height is " << rect1.getHeight() << endl;
  cout << "The area is " << rect1.getArea() << endl;
  cout << "The Perimeter is " << rect1.getPerimeter() << endl;
  cout << rect1 << endl << endl;

  RectangleFromGO rect2(13.2, 15.6);
  rect2.print();
  cout << "The color is " << rect2.getColor() << endl;
  cout << "The color filled is " << rect2.getFilled() << endl;
  rect2.setColor("Cyan");
  cout << "After setting, the color is " << rect2.getColor() << endl;
  cout << "The width is " << rect2.getWidth() << endl;
  cout << "The height is " << rect2.getHeight() << endl;
  cout << "The area is " << rect2.getArea() << endl;
  cout << "The Perimeter is " << rect2.getPerimeter() << endl;
  cout << rect2 << endl << endl;

  RectangleFromGO rect3;
  rect3.print();
  cout << "The color is " << rect3.getColor() << endl;
  cout << "The color filled is " << rect3.getFilled() << endl;
  cout << "The width is " << rect3.getWidth() << endl;
  cout << "The height is " << rect3.getHeight() << endl;
  cout << "The area is " << rect3.getArea() << endl;
  cout << "The Perimeter is " << rect3.getPerimeter() << endl;
  rect3.setHeight(26.7);
  rect3.setWidth(14.98);
  rect3.setColor("Indigo");
  cout << "The width is " << rect3.getWidth() << endl;
  cout << "The height is " << rect3.getHeight() << endl;
  cout << "The area is " << rect3.getArea() << endl;
  cout << "The Perimeter is " << rect3.getPerimeter() << endl;
  cout << rect3 << endl << endl;

  return 0;
}

/*
The circle is created and the radius is 5.3
Color: Blue and filled: 1
The color is Blue
The color filled is 1
The radius is 5.3
The area is 88.2473
The diameter is 10.6
The circle printed with ostream!
The radius is 5.3
Color: Blue and Area: 88.2473


The circle is created and the radius is 15.3
Color: white and filled: 1
The color is white
The color filled is 1
After setting, the color is Green
The radius is 15.3
The area is 735.415
The diameter is 30.6
The circle printed with ostream!
The radius is 15.3
Color: Green and Area: 735.415


The circle is created and the radius is 0
Color: white and filled: 1
The color is white
The color filled is 1
The radius is 0
The area is 0
The diameter is 0
The circle printed with ostream!
The radius is 26.7
Color: Yellow and Area: 2239.61


The rectangle  width is 27.9 and the height is 15.6
Color: Red and filled: 0
The color is Red
The color filled is 0
The width is 27.9
The height is 15.6
The area is 435.24
The Perimeter is 87
The Rectangle printed with ostream!
The width and height is 27.9, 15.6
Color: Red and Area: 435.24


The rectangle  width is 13.2 and the height is 15.6
Color: white and filled: 1
The color is white
The color filled is 1
After setting, the color is Cyan
The width is 13.2
The height is 15.6
The area is 205.92
The Perimeter is 57.6
The Rectangle printed with ostream!
The width and height is 13.2, 15.6
Color: Cyan and Area: 205.92


The rectangle  width is 0 and the height is 0
Color: white and filled: 1
The color is white
The color filled is 1
The width is 0
The height is 0
The area is 0
The Perimeter is 0
The width is 14.98
The height is 26.7
The area is 399.966
The Perimeter is 83.36
The Rectangle printed with ostream!
The width and height is 14.98, 26.7
Color: Indigo and Area: 399.966

*/
