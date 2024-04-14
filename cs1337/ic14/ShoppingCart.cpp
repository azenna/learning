#include <algorithm>
#include <iostream>
#include <numeric>
#include <string>

#include "ItemToPurchase.h"
#include "ShoppingCart.h"

using namespace std;
/*
    Default constructor
    Parameterized constructor which takes the customer name and date as
   parameters (1 pt) Private data members string customerName - Initialized in
   default constructor to "none" string currentDate - Initialized in default
   constructor to "March 29, 2023" vector < ItemToPurchase > cartItems Public
   member functions GetCustomerName() accessor (1 pt) GetDate() accessor (1 pt)
        AddItem()
            Adds an item to cartItems vector. Has a parameter of type
   ItemToPurchase. Does not return anything. RemoveItem() Removes item from
   cartItems vector. Has a string (an item's name) parameter. Does not return
   anything. If item name cannot be found, output this message: Item not found
   in cart. Nothing removed. ModifyItem() Modifies an item's description, price,
   and/or quantity. Has a parameter of type ItemToPurchase. Does not return
   anything. If item can be found (by name) in cart, check if parameter has
   default values for description, price, and quantity. If not, modify item in
   cart. If item cannot be found (by name) in cart, output this message: Item
   not found in cart. Nothing modified. GetNumItemsInCart() (2 pts) Returns
   quantity of all items in cart. Has no parameters. GetCostOfCart() (2 pts)
            Determines and returns the total cost of items in cart. Has no
   parameters. PrintTotal() Outputs total of objects in cart. If cart is empty,
   output this message: SHOPPING CART IS EMPTY PrintDescriptions() Outputs each
   item's description.
*/

ShoppingCart::ShoppingCart() {
  customerName = "none";
  currentDate = "March 29, 2023";
  cartItems = vector<ItemToPurchase>();
}
ShoppingCart::ShoppingCart(char *cn, char *cd)
    : customerName(cn), currentDate(cd) {
  cartItems = vector<ItemToPurchase>();
}
string ShoppingCart::GetCustomerName() const { return customerName; }
string ShoppingCart::GetDate() const { return currentDate; }
void ShoppingCart::AddItem(ItemToPurchase item) { cartItems.push_back(item); }
void ShoppingCart::RemoveItem(string itemName) {
  auto it = remove_if(
      cartItems.begin(), cartItems.end(),
      [itemName](ItemToPurchase &item) { return item.GetName() == itemName; });
  if (it == cartItems.end()) {
    cout << "Item not found in cart. Nothing removed." << endl;
  } else {
    cartItems.erase(it, cartItems.end());
  }
}
void ShoppingCart::ModifyItem(ItemToPurchase item) {
  for (ItemToPurchase &oItem : cartItems) {
    if (item.GetName() == oItem.GetName()) {
      oItem = item;
      return;
    }
  }
  cout << "Item not found in cart. Nothing modified" << endl;
}
int ShoppingCart::GetNumItemsInCart() {
  return accumulate(
      cartItems.begin(), cartItems.end(), 0,
      [](int acc, ItemToPurchase &item) { return acc + item.GetQuantity(); });
}
int ShoppingCart::GetCostOfCart() {
  return accumulate(cartItems.begin(), cartItems.end(), 0,
                    [](int acc, ItemToPurchase &item) {
                      return item.GetPrice() * item.GetQuantity() + acc;
                    });
}
/* John Doe's Shopping Cart - March 29, 2023
Number of Items: 8

Nike Romaleos 2 @ $189 = $378
Chocolate Chips 5 @ $3 = $15
Powerbeats 2 Headphones 1 @ $128 = $128

Total: $521 */
void ShoppingCart::PrintTotal() {
  cout << "OUTPUT SHOPPING CART" << endl;
  cout << customerName << "'s Shopping Cart - " << currentDate << endl;
  cout << "Number of Items: " << this->GetNumItemsInCart() << endl;
  if (cartItems.size() == 0) {
    cout << endl << "SHOPPING CART IS EMPTY" << endl;
  } else {
    cout << endl;
    for (ItemToPurchase &item : cartItems) {
      item.PrintItemCost();
    }
  }
  cout << endl << "Total: $" << this->GetCostOfCart() << endl;
}

/*
John Doe's Shopping Cart - March 29, 2023

Item Descriptions
Nike Romaleos: Volt color, Weightlifting shoes
Chocolate Chips: Semi-sweet
Powerbeats 2 Headphones: Bluetooth headphones */

void ShoppingCart::PrintDescriptions() {
  cout << "OUTPUT ITEMS' DESCRIPTIONS" << endl;
  cout << customerName << "'s Shopping Cart - " << currentDate << endl;
  cout << endl << "Item Descriptions" << endl;
  for (ItemToPurchase &item : cartItems) {
    item.PrintItemDescription();
  }
}
