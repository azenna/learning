#ifndef CATH
#define CATH

#include "Pet.h"
#include <string>

class Cat : public Pet {
private:
  string catBreed;

public:
  Cat();
  Cat(string name, int age, string breed);
  Cat(string breed);
  string GetBreed() const;
  virtual void SetBreed(string breed);
  void PrintInfo();
};

#endif
