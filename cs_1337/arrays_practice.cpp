#include <iostream>
using namespace std;
const int SIZE = 10;

int linearSearch(int list[], int key, int size) {
  for (int i = 0; i < size; i++) {
    if (list[i] == key) {
      return i;
    }
  }
  return -1;
}
int eliminateDuplicates(int numbers[SIZE], int result[SIZE]) {
  int i = 0;
  for (int j = 0; j < SIZE; j++) {
    if (linearSearch(result, numbers[j], i) == -1) {
      result[i] = numbers[j];
      i++;
    }
  }
  return i;
}

int main() {
  int numbers[SIZE];

  // Read and store numbers in an array if it is new
  for (int i = 0; i < SIZE; i++) {
    cin >> numbers[i];
  }

  int result[SIZE];
  int length;

  length = eliminateDuplicates(numbers, result);

  cout << "The number of distinct integers is " << length << endl;
  cout << "The distinct integers are ";

  for (int i = 0; i < length; i++) {
    cout << result[i] << " ";
  }
  cout << endl;
}
