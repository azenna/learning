#include <iostream>
#include <cstdlib>
#include <ctime>
#include <iomanip>
using namespace std;
const int ROW = 4;
const int COL = 4;


// nested for loop to populate 2d matrix
void popMatrix(int matrix[ROW][COL]) {
  for (int i = 0; i < ROW; i++) {
    for (int j = 0; j < COL; j++) {
      matrix[i][j] = rand() % 50;
    }
  }
}

// Prints a single row of a matrix
void printRow(int v[COL]) {
  for (int i = 0; i < COL; i++) {
    cout << setw(4) << v[i];
  }
}

// Prints an entire matrix using printRow on each row of matrix
void printMatrix(int m[ROW][COL]) {
  for(int i = 0; i < ROW; i++){
      cout << endl;
      printRow(m[i]);
  }
  cout << endl << endl;
}


// traverse the array using diagonal
// indicies
// Pseudocode
// indexes <- (0, 0), (1, 1) .... (Max, Max)
// sum (arrayAt indexes array)
int sumMajorDiagonal(int m[ROW][COL]) {
    int total = 0;
    for(int i = 0; i < ROW; i++){
        total += m[i][i];
    }
    return total;
}

// traverse the array using diagonal indicies
// on the minor diagonal
// Pseudocode
// indexes <- (0, Max), (1, Max - 1), ... (1 == Max, Max == 0) 
// sum (arrayAt indexes array)
int sumOtherDiagonal(int m[ROW][COL]) {
  int total = 0;
  for(int i = 0; i < ROW; i++){
      total += m[i][ROW - 1 - i];
  }
  return total;
}

// Pseudocode
// 
// start
// seed <- getSeed
// randomizeSeed
//
// matrix <- randomMatrix
// print matrix
//
// print (sumMajorDiag matrix)
// print (sumMinorDiag matrix)
int main(){
    
    int seed;
    cout << "Enter a seed value: ";
    cin >> seed;

    srand(seed);

    int matrix[ROW][COL] = {0};
    popMatrix(matrix);

    printMatrix(matrix);

    cout << "Sum of the elements in the major diagonal is "
        << sumMajorDiagonal(matrix) << endl;

    cout << "Sum of the elements in the other diagonal is "
        << sumOtherDiagonal(matrix) << endl;

    return 0;
}
