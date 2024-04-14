#include "Cat.h"
#include <iostream>
#include <string>

using namespace std;

int main() {

  string petName, catName, catBreed;
  int petAge, catAge;

  Pet myPet;
  Cat myCat;

  // cout << "Enter your pet name: " ;
  getline(cin, petName);
  // cout << "Enter your pet age: " ;
  cin >> petAge;
  cin.ignore();
  // cout << "Enter your cat name: " ;
  getline(cin, catName);
  // cout << "Enter your cat age: " ;
  cin >> catAge;
  cin.ignore();
  // cout << "Enter your cat breed: " ;
  getline(cin, catBreed);
  // cout << endl;

  // TODO: Create generic pet (using petName, petAge) and then call PrintInfo

  myPet.SetName(petName);
  myPet.SetAge(petAge);
  myPet.PrintInfo();
  cout << endl;

  // TODO: Create cat pet (using catName, catAge, catBreed) and then call
  // PrintInfo

  myCat.SetName(catName);
  myCat.SetAge(catAge);
  myCat.SetBreed(catBreed);
  myCat.PrintInfo();
  cout << endl;

  // TODO: Use GetBreed(), to output the breed of the cat

  cout << "Breed of my cat is: " << myCat.GetBreed() << endl;
  /*
          Pet *ptr1 = nullptr;
          ptr1 = &myCat;
          ptr1->SetAge(20);
          ptr1->SetBreed(catBreed);
          ptr1->PrintInfo();
  */
  Pet dog(petName, petAge);
  dog.PrintInfo();
  cout << endl;

  Cat cat(catName, catAge, catBreed);
  cat.PrintInfo();
  cout << endl;

  Cat cat1(catBreed);
  cat1.PrintInfo();
  cout << endl;

  Cat cat2;
  cat2.PrintInfo();
  cout << endl;

  Pet dog1;
  dog1.PrintInfo();
  cout << endl;
}

/*
Enter your pet name: Honey
Enter your pet age: 13
Enter your cat name: Sugar
Enter your cat age: 14
Enter your cat breed: Little Sugar
Pet Information:
   Name: Honey
   Age: 13

Cat Information:
Pet Information:
   Name: Sugar
   Age: 14
   Breed: Little Sugar

Breed of my cat is: Little Sugar
Pet Information:
   Name: Honey
   Age: 13

Cat Information:
Pet Information:
   Name: Sugar
   Age: 14
   Breed: Little Sugar

Cat Information:
Pet Information:
   Name: Tommy
   Age: 10
   Breed: Little Sugar

Cat Information:
Pet Information:
   Name: Tommy
   Age: 10
   Breed: Rajapalayam

Pet Information:
   Name: Tommy
   Age: 10



*/
/*
Bojangles
3
Eclair
1
Siamese
*/
