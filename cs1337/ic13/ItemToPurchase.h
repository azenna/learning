#ifndef ITEM_TO_PURCHASE_H
#define ITEM_TO_PURCHASE_H

#include <string>
using namespace std;

/* Type your code here */
class ItemToPurchase {
public:
  ItemToPurchase(){};
  void SetName(string name);
  string GetName();
  void SetPrice(int price);
  int GetPrice();
  void SetQuantity(int quantity);
  int GetQuantity();

private:
  string itemName;
  int itemPrice;
  int itemQuantity;
};

#endif
