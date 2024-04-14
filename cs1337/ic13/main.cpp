#include <iostream>
using namespace std;

#include "ItemToPurchase.h"

int main() {

  /* Type your code here */
  cout << "Item 1" << endl;

  ItemToPurchase item1 = ItemToPurchase();
  string name;
  cout << "Enter the item name:" << endl;
  getline(cin, name);
  item1.SetName(name);

  int price;
  cout << "Enter the item price:" << endl;
  cin >> price;
  item1.SetPrice(price);

  int quantity;
  cout << "Enter the item quantity:" << endl;
  cin >> quantity;
  item1.SetQuantity(quantity);

  cout << endl << "Item 2" << endl;

  ItemToPurchase item2 = ItemToPurchase();

  cout << "Enter the item name:" << endl;
  cin.ignore();
  getline(cin, name);
  item2.SetName(name);

  cout << "Enter the item price:" << endl;
  cin >> price;
  item2.SetPrice(price);

  cout << "Enter the item quantity:" << endl;
  cin >> quantity;
  item2.SetQuantity(quantity);

  cout << endl << "TOTAL COST" << endl;
  int item1Total = item1.GetQuantity() * item1.GetPrice();
  int item2Total = item2.GetQuantity() * item2.GetPrice();

  cout << item1.GetName() << ' ' << item1.GetQuantity() << " @ $"
       << item1.GetPrice() << " = $" << item1Total << endl;
  cout << item2.GetName() << ' ' << item2.GetQuantity() << " @ $"
       << item2.GetPrice() << " = $" << item2Total << endl;
  cout << endl << "Total: $" << item1Total + item2Total << endl;
  return 0;
}
