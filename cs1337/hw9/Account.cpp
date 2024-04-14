#include "Account.h"
#include <vector>
using namespace std;

/* class Account {
private:
  int accountNumber;
  int numOwners;
  Person *ownerPtr;
  static int accountCounter;
  double balance;

public:
  Account(int, double);
  ~Account();
  int withdraw(double);
  int deposit(double);
  void setOwner(int, Person);
  Person getOwner(int) const;
  int getAccountNumber() const;
  double getBalance() const;
  int getaNumOwners() const;
}; */

int Account::accountCounter = 1000;

Account::Account(int numberOwners, double amount)
    : numOwners(numberOwners), balance(amount) {
  accountNumber = accountCounter;
  ownerPtr = new Person[numberOwners];
  accountCounter += 1;
}

Account::~Account() { delete[] ownerPtr; }

int Account::withdraw(double amount) {
  if (amount > 0 && amount <= balance) {
    balance -= amount;
    return 0;
  } else if (amount > balance) {
    return 1;
  } else {
    return 2;
  }
}

int Account::deposit(double amount) {
  if (amount > 0) {
    balance += amount;
    return 0;
  }
  return 1;
}

void Account::addOwner(Person person) {
  Person *newOwnerPtr = new Person[numOwners + 1];
  for (int i = 0; i < numOwners; i++) {
    newOwnerPtr[i] = ownerPtr[i];
  }
  newOwnerPtr[numOwners] = person;
  numOwners += 1;

  delete[] ownerPtr;
  ownerPtr = newOwnerPtr;
}

int Account::delOwner(Person person) {

  vector<Person> newOwners;

  for (int i = 0; i < numOwners; i++) {
    if (ownerPtr[i].name == person.name &&
        ownerPtr[i].address == person.address &&
        ownerPtr[i].DOB.day == person.DOB.day &&
        ownerPtr[i].DOB.month == person.DOB.month &&
        ownerPtr[i].DOB.year == person.DOB.year) {
      continue;
    }
    newOwners.push_back(ownerPtr[i]);
  }

  if (newOwners.size() == numOwners) {
    return 1;
  } else if (newOwners.size() == 0) {
    return 2;
  }

  numOwners -= 1;
  Person *newOwnerPtr = new Person[numOwners];

  for (int i = 0; i < numOwners; i++) {
    newOwnerPtr[i] = newOwners[i];
  }

  delete[] ownerPtr;
  ownerPtr = newOwnerPtr;

  return 0;
}

void Account::setOwner(int ind, Person p) { ownerPtr[ind] = p; }

Person Account::getOwner(int ind) const { return ownerPtr[ind]; }

int Account::getAccountNumber() const { return accountNumber; }

double Account::getBalance() const { return balance; }

int Account::getNumOwners() const { return numOwners; }
