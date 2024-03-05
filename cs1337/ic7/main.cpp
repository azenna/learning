#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>

using namespace std;

const int MAXPRODUCTS = 100;

void readConfiguration(string codes[MAXPRODUCTS], string names[MAXPRODUCTS],
                       double prices[MAXPRODUCTS], int &numProducts) {

  ifstream file("menu.txt");

  numProducts = 0;

  while (file >> codes[numProducts] >> names[numProducts] >>
         prices[numProducts]) {
    numProducts += 1;
  }

  cout << numProducts << " items loaded.\n";
}

void displayItem(string &name, double price) {
  cout << name << ": $" << fixed << setprecision(2) << price << endl;
}

// return valid index if the item is found, return -1 otherwise.
int findItem(string inputCode, string names[MAXPRODUCTS], int size) {

  for (int i = 0; i < size; i++) {
    if (names[i] == inputCode) {
      return i;
    }
  }

  return -1;
}

// read order string like “A1 A2 E1 E2 S1” and generate the restaurant bill.
// Output the item name and price in each line, total in the final line.
void process(string order, string codes[MAXPRODUCTS], string names[MAXPRODUCTS],
             double prices[MAXPRODUCTS], int &numProducts) {
  istringstream stream(order);

  string code;
  int idx;
  double price, total;

  while (stream >> code) {
    idx = findItem(code, codes, numProducts);
    if (idx != -1) {
      price = prices[idx];
      total += price;
      displayItem(names[idx], price);
    } else {
      cout << code << " is invalid. Skipping it." << endl;
    }
  }
  cout << "Total: $" << total << endl;
}

int main() {
  string codes[MAXPRODUCTS];
  string names[MAXPRODUCTS];
  double prices[MAXPRODUCTS];

  int numProducts = 0;
  readConfiguration(codes, names, prices, numProducts);

  string order;
  cout << "Enter your order string: " << endl;
  getline(cin, order);

  process(order, codes, names, prices, numProducts);
}
