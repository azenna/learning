#include <iostream>
using namespace std;

#include "ItemToPurchase.h"

ItemToPurchase::ItemToPurchase(){};
ItemToPurchase::ItemToPurchase(char *name, char *description, int price,
                               int quantity)
    : itemName(name), itemDescription(description), itemQuantity(quantity),
      itemPrice(price) {}
void ItemToPurchase::SetName(string name) { itemName = name; }
string ItemToPurchase::GetName() { return itemName; }
void ItemToPurchase::SetPrice(int price) { itemPrice = price; }
int ItemToPurchase::GetPrice() { return itemPrice; }
void ItemToPurchase::SetQuantity(int quantity) { itemQuantity = quantity; }
int ItemToPurchase::GetQuantity() { return itemQuantity; }
void ItemToPurchase::SetDescription(string description) {
  itemDescription = description;
}
string ItemToPurchase::GetDescription() const { return itemDescription; }
// Bottled Water 10 @ $1 = $10
void ItemToPurchase::PrintItemCost() {
  cout << itemName << " " << itemQuantity << " @ $" << itemPrice << " = $"
       << itemPrice * itemQuantity << endl;
}
// Bottled Water: Deer Park, 12 oz.
void ItemToPurchase::PrintItemDescription() {
  cout << itemName << ": " << itemDescription << endl;
}
