#ifndef ACCOUNT_H
#include <string>
using namespace std;

struct Date {
  int month;
  int day;
  int year;
};

struct Person // stores account owner’s info
{
  string name;
  Date DOB;
  string address;
};

class Account {
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
  void addOwner(Person);
  int delOwner(Person);
  void setOwner(int, Person);
  Person getOwner(int) const;
  int getAccountNumber() const;
  double getBalance() const;
  int getNumOwners() const;
};

#endif
