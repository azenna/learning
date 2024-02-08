#include <cassert>
#include <iostream>
using namespace std;
#define SIZE 10

void swap(int *a, int *b) {
  int temp = *a;
  *a = *b;
  *b = temp;
}

// Pseudocode
// for i in arraySize:
//   min_index = findMinumum in array after i
//   if arr at min_index < arr[i]:
//      swap arr at min_index and arr[i]
void SelectionSort(int numbers[], int size) {
  int min_index;

  for (int i = 0; i < size; i++) {
    min_index = i;

    for (int j = i + 1; j < size; j++) {
      if (numbers[j] < numbers[min_index]) {
        min_index = j;
      }
    }

    if (min_index != i) {
      swap(&numbers[min_index], &numbers[i]);
    }
  }
}

void test() {
  int unsorted[5] = {5, 4, 3, 2, 1};
  SelectionSort(unsorted, 5);

  for (int i = 1; i <= 5; i++) {
    assert(unsorted[i - 1] == i);
  }
}

// Pseudo code:
// arr <- initializeArray
// until elements < SIZE do
//   elements <- promptUserForElements
// readIn elements
// selectionSort elements
// showSortedArray elements
int main() {
  test();
  int arr[SIZE];

  int elements;
  do {
    cout << "How many elements? ";
    cin >> elements;

    if (elements >= 11 || elements <= 0) {
      cout << "The number of elements should be less than 11 or greater than 0"
           << endl;
    }
  } while (elements >= 11 || elements <= 0);

  for (int i = 0; i < elements; i++) {
    cin >> arr[i];
  }

  SelectionSort(arr, elements);

  cout << "The sorted array is : ";

  for (int i = 0; i < elements; i++) {
    cout << arr[i] << ' ';
  }
  cout << endl;
}
