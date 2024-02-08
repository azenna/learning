#include <cstdlib>
#include <ctime>
#include <iomanip>
#include <iostream>
using namespace std;

const int ROW = 3; // Number of divisions
const int COL = 3;

// Function to populates a matrix by iterating over
// matrix and assigning random values
void popMatrix(double matrix[ROW][COL]) {
  for (int i = 0; i < ROW; i++) {
    for (int j = 0; j < COL; j++) {
      matrix[i][j] = rand() % 50;
    }
  }
}

// Adds to matrixes using a nexted for loop
void addMatrix(double m1[ROW][COL], double m2[ROW][COL], double m3[ROW][COL]) {
  for (int i = 0; i < ROW; i++) {
    for (int j = 0; j < COL; j++) {
      m3[i][j] = m1[i][j] + m2[i][j];
    }
  }
}

// Prints a single row of a matrix
void printRow(double v[COL]) {
  for (int i = 0; i < COL; i++) {
    cout << setw(4) << v[i];
  }
}

// Prints an entire matrix using printRow on each row of matrix
void printMatrix(double m[ROW][COL]) {
  for (int i = 0; i < ROW; i++) {
    cout << endl;
    printRow(m[i]);
  }
  cout << endl << endl;
}

/** Print result - Follow this logic so that you have a proper display as in
 * test cases*/
// Prints a formatted representation of matrix addition
void printResult(double m1[ROW][COL], double m2[ROW][COL], double m3[ROW][COL],
                 char op) {
  for (int i = 0; i < ROW; i++) {
    printRow(m1[i]);
    if (ROW / 2 == i) {
      cout << "  " << op << "  ";
    } else {
      cout << setw(5) << "";
    }
    printRow(m2[i]);
    if (ROW / 2 == i) {
      cout << "  =  ";
    } else {
      cout << setw(5) << "";
    }
    printRow(m3[i]);
    cout << setw(4) << endl;
  }
}

// Program to randomly generate two matrixes based on seed value
// and add together
// Pseudocode:
//
// addMatrixes = nestedForLoopTraverseZip +
//
// start
//
// seed <- getSeed
// matrix1, matrix2 = randMatrix seed, randMatrix seed
// displayMatrix matrix1
// displayMatrix matrix2
// resultMatrix = addMatrixes matrix1 matrix2
//
// displayFormattedMatrixAddition matrix1 matrix2 resultMatrix
//
// exit
int main() {
  int seed;
  cout << "Enter a seed value: ";
  cin >> seed;
  srand(seed);

  double matrix1[ROW][COL], matrix2[ROW][COL], matrix3[ROW][COL];

  popMatrix(matrix1);
  popMatrix(matrix2);

  cout << "Matrix1 is : ";
  printMatrix(matrix1);

  cout << "Matrix2 is : ";
  printMatrix(matrix2);

  double resultMatrix[ROW][COL] = {0};
  // Add two matrices and print the result
  addMatrix(matrix1, matrix2, resultMatrix);
  cout << "The addition of the matrices is " << endl;
  printResult(matrix1, matrix2, resultMatrix, '+');
}
