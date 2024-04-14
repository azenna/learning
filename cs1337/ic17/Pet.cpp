
#include "Pet.h"
#include <iostream>
#include <string>
using namespace std;

// default constructor
Pet::Pet() {
  petName = "Tommy";
  petAge = 10;
}

Pet::Pet(string pName, int pAge) : petName(pName), petAge(pAge) {}

void Pet::SetName(string name) { petName = name; }

void Pet::SetAge(int age) { petAge = age; }

int Pet::GetAge() { return petAge; }

string Pet::GetName() { return petName; }

void Pet::PrintInfo() {
  cout << "Pet Information: " << endl;
  cout << "   Name: " << petName << endl;
  cout << "   Age: " << petAge << endl;
}
