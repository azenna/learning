#ifndef ITEM_TO_PURCHASE_H
#define ITEM_TO_PURCHASE_H

#include <string>
using namespace std;

/* Type your code here */
class ItemToPurchase {
public:
  ItemToPurchase();
  ItemToPurchase(char *, char *, int, int);
  void SetName(string name);
  string GetName();
  void SetPrice(int price);
  int GetPrice();
  void SetQuantity(int quantity);
  int GetQuantity();
  void SetDescription(string description);
  string GetDescription() const;
  // Bottled Water 10 @ $1 = $10
  void PrintItemCost();
  // Bottled Water: Deer Park, 12 oz.
  void PrintItemDescription();

private:
  string itemName;
  string itemDescription;
  int itemPrice;
  int itemQuantity;
};

#endif
