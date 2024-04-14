#ifndef PRODUCT_H
#define PRODUCT_H
#include <string>

using namespace std;
class Product {
private:
  string PLU;
  string name;
  int type;
  double price;
  int inventory;

public:
  void setProductAttributes(string, string, int, double, int);
  void setInventory(int);
  string getPLU() const;
  string getName() const;
  int getType() const;
  double getPrice() const;
  int getInventory() const;
};
#endif
