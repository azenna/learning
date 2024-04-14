#include "Account.h"
#include <iomanip>
#include <iostream>

using namespace std;

const int MAX_NUM_ACCOUNTS = 4;
Account *accountArray[MAX_NUM_ACCOUNTS];

int main() {

  for (int i = 0; i < MAX_NUM_ACCOUNTS; i++) {
    accountArray[i] = nullptr;
  }

  int choice = 0, currentAccounts = 0;
  while (choice != 8) {
    cout << "Menu" << endl
         << "----" << endl
         << "1->Create account 2->Deposit   3->Withdraw     4->Display " << endl
         << "5->Delete owner   6->Add owner 7->Delete accnt 8->Quit    "
         << endl;
    cin >> choice;

    switch (choice) {
    case 1: {
      if (currentAccounts == 4) {
        cout << "Max number of accounts reached, cannot add a new account"
             << endl;
        break;
      }
      int numOwners;
      cout << "Enter number of owners: ";
      cin >> numOwners;

      double amount;
      cout << "Enter amount: ";
      cin >> amount;

      Account *account = new Account(numOwners, amount);

      for (int i = 0; i < numOwners; i++) {
        Person person;
        cout << "Enter owner's name: ";
        if (i == 0) {
          cin.ignore();
        }
        getline(cin, person.name);

        cout << "Enter owner's DOB, month, day then year: ";
        cin >> person.DOB.month >> person.DOB.day >> person.DOB.year;

        cout << "Enter owner's address: ";
        cin.ignore();
        getline(cin, person.address);

        account->setOwner(i, person);
      }
      accountArray[currentAccounts] = account;
      currentAccounts += 1;

      cout << "Account #" << account->getAccountNumber() << " created" << endl;
    } break;
    case 2: {
      int accountNum;
      cout << "Enter account number: ";
      cin >> accountNum;

      for (int i = 0; i < currentAccounts; i++) {
        if (accountArray[i]->getAccountNumber() == accountNum) {
          double amount;
          cout << "Enter amount: ";
          cin >> amount;

          int code = accountArray[i]->deposit(amount);
          if (code == 0)
            cout << "New balance is $" << fixed << setprecision(2)
                 << accountArray[i]->getBalance() << endl;
          else
            cout << "Amount cannot be negative, deposit not executed" << endl;
          break;
        } else if (i == currentAccounts - 1)
          cout << "No such account" << endl;
      }

    } break;
    case 3: {
      int accountNum;
      cout << "Enter account number: ";
      cin >> accountNum;

      for (int i = 0; i < currentAccounts; i++) {
        if (accountArray[i]->getAccountNumber() == accountNum) {
          double amount;
          cout << "Enter amount: ";
          cin >> amount;

          int code = accountArray[i]->withdraw(amount);
          if (code == 0)
            cout << "New balance is $" << fixed << setprecision(2)
                 << accountArray[i]->getBalance() << endl;
          else if (code == 1)
            cout << "Insufficient balance, withdrawal not executed" << endl;
          else
            cout << "Amount cannot be negative, withdrawal not executed"
                 << endl;
          break;
        } else if (i == currentAccounts - 1)
          cout << "No such account" << endl;
      }
    } break;
    case 4: {
      for (int i = 0; i < currentAccounts; i++) {
        Account *account = accountArray[i];
        cout << "Account Number: " << account->getAccountNumber() << endl;
        cout << "--------------" << endl;
        for (int j = 0; j < account->getNumOwners(); j++) {
          Person p = accountArray[i]->getOwner(j);
          cout << "*Name: " << p.name << ", DOB: " << p.DOB.month << '/'
               << p.DOB.day << '/' << p.DOB.year << endl;
          cout << "Address: " << p.address << endl;
        }
        cout << "*Balance: $" << fixed << setprecision(2)
             << account->getBalance() << ' ' << endl;
      }
    } break;
    case 5: {

    } break;
    case 6: {
    } break;
    case 7: {
      int accountNum;
      cout << "Enter account number: ";
      cin >> accountNum;

      for (int i = 0; i < currentAccounts; i++) {
        if (accountArray[i]->getAccountNumber() == accountNum) {
          delete accountArray[i];
          for (int j = i + 1; j < currentAccounts; j++) {
            accountArray[j - 1] = accountArray[j];
          }
          currentAccounts -= 1;
        } else if (i == currentAccounts - 1)
          cout << "No such account" << endl;
      }

      cout << "Account deleted" << endl;
    } break;
    default:
      break;
    }
  }

  for (int i = 0; i < currentAccounts; i++) {
    delete accountArray[i];
  }

  return 0;
}
