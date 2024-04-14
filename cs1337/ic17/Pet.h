#ifndef PETH
#define PETH

#include <string>
using namespace std;

class Pet {
  // define the modifier:
protected:
  string petName;
  int petAge;

  // define the modifier:
public:
  Pet();
  Pet(string pName, int pAge);
  void SetName(string userName);
  string GetName();
  void SetAge(int userAge);
  int GetAge();
  void PrintInfo();
  virtual void SetBreed(string userBreed) {}
};

#endif
