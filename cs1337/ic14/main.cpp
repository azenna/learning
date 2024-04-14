#include "ItemToPurchase.h"
#include <iostream>
using namespace std;

#include "ShoppingCart.h"

void PrintMenu() {
  cout << "MENU" << endl
       << "a - Add item to cart" << endl
       << "d - Remove item from cart" << endl
       << "c - Change item quantity" << endl
       << "i - Output items' descriptions" << endl
       << "o - Output shopping cart" << endl
       << "q - Quit" << endl;
}

void ExecuteMenu(char option, ShoppingCart &theCart) {
  switch (option) {
    /* ADD ITEM TO CART
Enter the item name:
Nike Romaleos
Enter the item description:
Volt color, Weightlifting shoes
Enter the item price:
189
Enter the item quantity:
2 */
  case 'a': {
    cout << "ADD ITEM TO CART" << endl;

    string name, description;
    int price, quantity;
    cin.ignore();
    cout << "Enter the item name:" << endl;
    getline(cin, name);
    cout << "Enter the item description:" << endl;
    getline(cin, description);
    cout << "Enter the item price:" << endl;
    cin >> price;
    cout << "Enter the item quantity:" << endl;
    cin >> quantity;
    ItemToPurchase item = ItemToPurchase();
    item.SetName(name);
    item.SetDescription(description);
    item.SetPrice(price);
    item.SetQuantity(quantity);
    theCart.AddItem(item);
  } break;

  case 'd': {
    string name;
    cout << "REMOVE ITEM FROM CART" << endl
         << "Enter name of item to remove:" << endl;
    cin.ignore();
    getline(cin, name);
    theCart.RemoveItem(name);
  } break;
  case 'c': {
    string name, description;
    int price, quantity;
    cout << "CHANGE ITEM QUANTITY" << endl << "Enter the item name:" << endl;
    cin.ignore();
    getline(cin, name);
    cout << "Enter the item Description:" << endl;
    getline(cin, description);
    cout << "Enter the new quantity:" << endl;
    cin >> quantity;
    cout << "Enter the new price:" << endl;
    cin >> price;
    ItemToPurchase item = ItemToPurchase();
    item.SetName(name);
    item.SetDescription(description);
    item.SetPrice(price);
    item.SetQuantity(quantity);
    theCart.ModifyItem(item);
  } break;
  case 'i': {
    theCart.PrintDescriptions();
  } break;
  case 'o': {
    theCart.PrintTotal();
  } break;
  }
}

int main() {
  /* Type your code here */
  char name[14], date[18];
  cout << "Enter customer's name:" << endl;
  cin.getline(name, 14);
  cout << "Enter today's date:" << endl;
  cin.getline(date, 18);

  ShoppingCart theCart = ShoppingCart(name, date);

  cout << endl << "Customer name: " << name << endl;
  cout << "Today's date: " << date << endl;

  char choice = 0;
  while (choice != 'q') {
    choice = 0;
    cout << endl;
    PrintMenu();
    cout << endl;
    while (choice != 'a' && choice != 'd' && choice != 'c' && choice != 'i' &&
           choice != 'o' && choice != 'q') {
      cout << "Choose an option:" << endl;
      cin >> choice;
    }
    ExecuteMenu(choice, theCart);
  };

  return 0;
}
