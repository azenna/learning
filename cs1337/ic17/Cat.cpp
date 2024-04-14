#include "Cat.h"
#include "Pet.h"
#include <iostream>
#include <string>
using namespace std;

Cat::Cat() : Pet() { catBreed = "Rajapalayam"; }

Cat::Cat(string name, int age, string breed)
    : Pet(name, age), catBreed(breed) {}

Cat::Cat(string breed) : Pet(), catBreed(breed) {}

string Cat::GetBreed() const { return catBreed; }

void Cat::SetBreed(string breed) { catBreed = breed; }

// write the paramterized constructor and other getters, setters and print
// functions
void Cat::PrintInfo() {
  cout << "Cat Information:" << endl;
  Pet::PrintInfo();
  cout << "   Breed: " << catBreed << endl;
}
