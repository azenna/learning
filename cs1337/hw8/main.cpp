#include "Product.h"
#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

// Helper function for reading Product class from string
Product readProduct(const string &);
Product readProduct(const string &product) {
  istringstream stream(product);
  Product prod = Product();
  string PLU, name;
  int type, inventory;
  double price;
  stream >> PLU >> name >> type >> price >> inventory;
  prod.setProductAttributes(PLU, name, type, price, inventory);
  return prod;
}

// Outputs our product class
void printProduct(const Product &prod);
void printProduct(const Product &prod) {
  cout << "PLU: " << prod.getPLU() << ", " << setw(17) << left << prod.getName()
       << ", type: " << prod.getType() << ", unit price: " << setw(5) << right
       << prod.getPrice() << ", inventory: " << prod.getInventory() << endl;
}

// Function to format transactions for log
string mkTransaction(int, string, string, int);
string mkTransaction(int id, string PLU, string type, int amount) {
  return "Transaction #: " + to_string(id) + ", PLU: " + PLU +
         ", type: " + type + ", amount: " + to_string(amount);
}

/* Prompt the user for a file name.
Read the file to determine the number of records in the file. If the file
open is unsuccessful, print an error message and terminate. Dynamically
allocate an array of Product objects, with a size equal to the number of
records, and populate the array with the items read from the file by using
the appropriate mutator(s).  Then print the array. For name use setw(17) and
left. The remaining parameters are printed right. For price use setw(5) so
that your output will match with the testcase. Loop on displaying the
following menu of choices:
1.    Add to inventory
2.    Subtract from inventory
3.    Print info for all products
4.    Exit */
int main() {
  // prompt user for filename
  string fileName;
  cout << "Enter the file name: ";
  cin >> fileName;

  // open file and check that is good
  ifstream file(fileName);
  if (!file) {
    cout << "Failed to open file";
    return 0;
  }

  vector<Product> products;

  // read all products from open file to prodcuts vector
  string buffer;
  while (getline(file, buffer)) {
    if (buffer != "") {
      Product prod = readProduct(buffer);
      products.push_back(prod);
    }
  }

  // output number of products to user
  cout << "There are " << products.size() << " records in the file" << endl;

  // print out inventory of products
  cout << endl
       << "Content of object array" << endl
       << "-----------------------" << endl;

  for (auto &prod : products) {
    printProduct(prod);
  }

  // transactions to log user actions
  vector<string> transactions;
  // incrementer id for transaction log
  int transactionCounter = 1;
  int choice = 0;
  while (choice != 4) {
    cout << endl
         << "Menu" << endl
         << "----" << endl
         << "1->Add to inventory           , 2->Subtract from inventory" << endl
         << "3->Print info for all products, 4->Exit" << endl;
    cin.ignore();
    cin >> choice;

    // handler for choice
    switch (choice) {
    case 1: {
      string PLU;
      cout << "Enter the PLU: ";
      cin >> PLU;
      // try to find PLU in products else outupt not found
      auto it = find_if(products.begin(), products.end(),
                        [PLU](auto &prod) { return prod.getPLU() == PLU; });
      if (it != products.end()) {
        int amount;
        cout << "Enter amount to add: ";
        cin >> amount;
        if (amount <= 0) {
          cout << "Amount must be > 0" << endl;
        } else {
          it->setInventory(it->getInventory() + amount);
          transactions.push_back(mkTransaction(transactionCounter, PLU,
                                               "Add to inventory", amount));
          transactionCounter += 1;
        }
      } else {
        cout << "PLU not found" << endl;
      }
    } break;

    case 2: {
      // just a copypasta of the above code whith some values tweaked
      string PLU;
      cout << "Enter the PLU: ";
      cin >> PLU;
      auto it = find_if(products.begin(), products.end(),
                        [PLU](auto &prod) { return prod.getPLU() == PLU; });
      if (it != products.end()) {
        int amount;
        cout << "Enter amount to subtract: ";
        cin >> amount;
        if (amount <= 0) {
          cout << "Amount must be > 0" << endl;
        } else {
          transactions.push_back(
              mkTransaction(transactionCounter, PLU, "Subtract from inventory",
                            min(amount, it->getInventory())));
          it->setInventory(max(it->getInventory() - amount, 0));
          transactionCounter += 1;
        }
      } else {
        cout << "PLU not found" << endl;
      }
    } break;
    case 3: {
      cout << "Current inventory" << endl << "-----------------" << endl;
      for (Product &prod : products) {
        printProduct(prod);
      }
    } break;
    default:
      break;
    }
  }

  // ouput history at end of program
  cout << endl
       << "History of transactions" << endl
       << "-----------------------" << endl;

  // don't ask me why zylabs test cases are soo strang
  for (int i = 0; i < transactions.size() && i < 5; i++) {
    cout << transactions[transactions.size() - 1 - i] << endl;
  }

  return 0;
}
