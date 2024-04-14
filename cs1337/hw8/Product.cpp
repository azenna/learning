#include <string>

using namespace std;
#include "Product.h"

void Product::setProductAttributes(string sPLU, string sName, int sType,
                                   double sPrice, int sInventory) {
  PLU = sPLU;
  name = sName;
  type = sType;
  price = sPrice;
  inventory = sInventory;
}
void Product::setInventory(int i) { inventory = i; }
string Product::getPLU() const { return PLU; }
string Product::getName() const { return name; }
int Product::getType() const { return type; }
double Product::getPrice() const { return price; }
int Product::getInventory() const { return inventory; }
