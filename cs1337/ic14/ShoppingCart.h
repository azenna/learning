#ifndef SHOPPING_CART_H
#define SHOPPING_CART_H
#include <string>
#include <vector>

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

#include "ItemToPurchase.h"
class ShoppingCart {
private:
  string customerName;
  string currentDate;
  vector<ItemToPurchase> cartItems;

public:
  ShoppingCart();
  ShoppingCart(char *c, char *cd);
  string GetCustomerName() const;
  string GetDate() const;
  void AddItem(ItemToPurchase);
  void RemoveItem(string);
  void ModifyItem(ItemToPurchase);
  int GetNumItemsInCart();
  int GetCostOfCart();
  void PrintTotal();
  void PrintDescriptions();
};

#endif
