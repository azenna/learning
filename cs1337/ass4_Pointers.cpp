#include <cstdlib>
#include <ctime> // contains prototype for function time
#include <iostream>
using namespace std;

#define SIZE 150

void printArray(int randArray[]);        // Function prototype
void bubbleSort(int *list[]);            // Function prototype
void printPointerArray(int *ptrArray[]); // Function prototype
void swapIntPtr(int **xptr, int **yptr); // Function prototype


// swaps two ptr ptrs using a temporary value
void swapIntPtr(int **xptr, int **yptr) {
  int *temp = *xptr;
  *xptr = *yptr;
  *yptr = temp;
}

// iterates over non pointer array printing out valeus
void printArray(int randArray[]) {
  for (int i = 0; i < SIZE; i++) {
    cout << randArray[i] << ' ';
  }
  cout << endl;
}

// iterates over pointer array dereferecning each ptr
void printPointerArray(int *ptrArray[]) {
  for (int i = 0; i < SIZE; i++) {
    cout << *ptrArray[i] << ' ';
  }
  cout << endl;
}

// bubble sort function compares adjacent values and swaps if
// left is larger than right
// Pseudocode:
// bubbleSort(list):
//   for i from ize -1 to i = 1
//      for j from 0 to size - 1
//        if list[j] > list[j + 1]: swap(ptr list[j], ptr list[j + 1])
void bubbleSort(int *list[]) {
  for (int i = SIZE - 1; i > 0; i--) {
    for (int j = 0; j < SIZE - 1; j++) {
      if (*list[j] > *list[j + 1]) {
        swapIntPtr(&list[j], &list[j + 1]);
      }
    }
  }
}

int main() {

  srand(time(NULL));

  int dataArray[SIZE] = {0};
  int *pointerArray[SIZE];

  // Initializing values in Data Array
  for (int index = 0; index < SIZE; index++) {
    dataArray[index] = rand() % 3000;
  }

  // Printing four different data sets
  printf("Before Sorting, values in Data Array: \n");
  printArray(dataArray);
  printf("\n");

  // Initializing Pointer array with the address of each element in data array
  for (int index = 0; index < SIZE; index++) {
    pointerArray[index] = &dataArray[index];
  }

  printf("Before Sorting, values in Pointer Array and the value it is pointing "
         "at: \n");
  printPointerArray(pointerArray);
  printf("\n");

  // Calling function Bubble SOrt
  bubbleSort(pointerArray);

  // After Sorting printing the values
  printf("\n");
  printf("After Sorting, values in Pointer Array and the value it is pointing "
         "at:  \n");
  printPointerArray(pointerArray);
  printf("\n");

  printf("\n");
  printf("After Sorting, values in Data Array: \n");
  printArray(dataArray);
  printf("\n");
  return 0;
}
