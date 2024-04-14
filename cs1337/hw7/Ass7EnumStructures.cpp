#include <algorithm>
#include <functional>
#include <iostream>

using namespace std;

const int TRYS = 5;

struct Person {
  string name;
  string address;
};
struct Account {
  int accountNumber;
  Person ownerInfo;
  double balance;
};

template <typename T> T parseAndValidate(const string &str);

template <typename T>
T getConstrainedTrys(
    function<void()> out,
    function<bool(T)> extrapred = [](T val) { return true; },
    string type = "value");

/* This function takes as arguments the array of Accounts, the number of
 * Accounts populated so far passed by reference, and the size of the array
 * passed by value. It prompts the user for the data and populates the next
 * available element of the Account array. It performs all the necessary input
 * validations. It prints an error message if there is no available element. The
 * function returns void. */
void populateAccount(Account accounts[], int &numAccounts, int size);

/* This function takes as argument an Account structure variable passed by
 * reference. It prints the content of the structure variable. The function
 * returns void. */
void printAccount(const Account &account);

/* Prompt the user to enter the maximum number of Accounts. Perform input
validation. A valid value is an integer > 0. Dynamically allocate an array of
Accounts of the size entered by the user Display the menu of choices: 1->Enter
data for specific account, 2->Display data for specific account 3->Display data
for all accounts, 4->Quit Perform input validation on the user’s choice. A
user’s choice is valid if it is a choice on the menu. If the user chooses 1,
prompt the user for the account data, do input validation on the account number
and balance, and populate the next available element of the Account array. The
next available element is the lowest index element that is not populated. If
there is no available element (array is full), print an error message. Then
display the menu again. If the user chooses 2, prompt the user for the account
number. Perform input validation. If there is no account with that number, print
an error message. Else, display the data related to the account. Then display
the menu again. If the user chooses 3, print the data of all the accounts that
have been populated. Then display the menu again. If the user chooses 4,
terminate the program. */
int main() {
  int maxAccounts = getConstrainedTrys<int>(
      []() { cout << "Enter max number of accounts: "; });

  int populatedAccounts = 0;
  Account *accounts = new Account[maxAccounts];

  int choice = 0;
  while (choice != 4) {
    choice = getConstrainedTrys<int>(
        []() {
          cout << endl
               << "Menu:" << endl
               << "1->Enter data for specific account, 2->Display data for "
                  "specific account"
               << endl
               << "3->Display data for all accounts  , 4->Quit:" << endl;
        },
        [](int val) { return val > 0 && val < 5; }, "choice");

    switch (choice) {
    case 1: {
      populateAccount(accounts, populatedAccounts, maxAccounts);
    } break;
    case 2: {
      int accountNum =
          getConstrainedTrys<int>([]() { cout << "Enter account number: "; });

      for (int i = 0; i < populatedAccounts; i++) {
        if (accounts[i].accountNumber == accountNum) {
          printAccount(accounts[i]);
          break;
        } else if (i == populatedAccounts - 1) {
          cout << "Account not found" << endl;
        }
      }

    } break;
    case 3: {
      for (int i = 0; i < populatedAccounts; i++) {
        printAccount(accounts[i]);
      }
    } break;
    case 4: {
    } break;
    }
  }

  return 0;
}

template <> int parseAndValidate(const string &str) {
  if (all_of(str.begin(), str.end(), [](char c) { return isdigit(c); })) {
    return stoi(str);
  } else {
    throw -1;
  }
}
template <> double parseAndValidate(const string &str) {
  if (all_of(str.begin(), str.end(),
             [](char c) { return isdigit(c) || c == '.'; })) {
    return stod(str);
  } else {
    throw -1;
  }
}

template <typename T>
T getConstrainedTrys(function<void()> out, function<bool(T)> extrapred,
                     string type) {
  string line;

  for (int i = 0; i < TRYS; i++) {
    if (i == 0) {
      out();
    } else {
      cout << "Invalid " << type << ", please reenter: ";
    }

    getline(cin, line);

    try {
      T val = parseAndValidate<T>(line);
      if (extrapred(val)) {
        return val;
      }
    } catch (int) {
      continue;
    }
  }
  cout << "Too many unsuccessful attempts, exiting";
  exit(-1);
}

void printAccount(const Account &account) {
  cout << "Account #: " << account.accountNumber << endl
       << "Owner's name: " << account.ownerInfo.name << endl
       << "Owner's address: " << account.ownerInfo.address << endl
       << "Balance: " << account.balance << endl;
}

void populateAccount(Account accounts[], int &numAccounts, int size) {
  if (numAccounts + 1 > size) {
    cout << "Cannot execute, array is full" << endl;
    return;
  }

  Account account;
  account.accountNumber =
      getConstrainedTrys<int>([]() { cout << "Enter account number: "; });

  for (int i = 0; i < numAccounts; i++) {
    if (accounts[i].accountNumber == account.accountNumber) {
      cout << "Duplicate account number";
      exit(1);
    }
  }
  account.balance =
      getConstrainedTrys<double>([]() { cout << "Enter balance: "; });

  Person person;

  cout << "Enter owner's name: ";
  getline(cin, person.name);

  cout << "Enter owner's address: ";
  getline(cin, person.address);

  account.ownerInfo = person;

  accounts[numAccounts] = account;
  numAccounts += 1;
}
