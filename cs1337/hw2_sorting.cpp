#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>

using namespace std;

const int NUM_ELMTS = 18;

/* This function sorts array1 and maintains the parallelism
of array2 and array3
Whenever elements of array1 are swapped, the elements of array 2
and array3 at the same indices are also swapped
*/
void modifiedSortGPA(double array1[], int array2[], string array3[], int size) {
  int minIdx;
  for (int i = 0; i < size; i++) {
    minIdx = i;
    for(int j = i + 1; j < size; j++) {
      if (array1[j] < array1[minIdx]) {
        swap(array1[j], array1[minIdx]);
        swap(array2[j], array2[minIdx]);
        swap(array3[j], array3[minIdx]);
      }
    }
  }
}

/* This function sorts array2 and maintains the parallelism
of array1 and array3
Whenever elements of array2 are swapped, the elements of array 1
and array3 at the same indices are also swapped
*/
void modifiedSortID(int array2[], double array1[], string array3[], int size) {
  int minIdx;
  for (int i = 0; i < size; i++) {
    minIdx = i;
    for (int j = i + 1; j < size; j++) {
      if (array2[j] < array2[minIdx]) {
        swap(array2[j], array2[minIdx]);
        swap(array1[j], array1[minIdx]);
        swap(array3[j], array3[minIdx]);
      }
    }
  }
}

/* This function implements linear search on an array. It takes the following
arguments: arr: the array, numElems: number of elements of array, value: search
value, and nIter. nIter is a reference variable used to pass the number of
iterations back to the calling function. The function returns the index where
the match is found, -1 if no match is found
*/
int linearSearchID(int arr[], int numElems, int value, int &nIter) {
  nIter = 0;
  for (int i = 0; i < numElems; i++) {
    nIter++;
    /* cout << value << ' ' << arr[nIter] << ' ' << nIter << endl; */
    if (arr[i] == value) {
      return i;
    }
  }
  return -1;
}

/* This function implements binary search on an array. It takes the following
arguments: arr: the array, numElems: number of elements of array, value: search
value, and nIter. nIter is a reference variable used to pass the number of
iterations back to the calling function. The function returns the index where
the match is found, -1 if no match is found
*/
int binarySearchID(int arr[], int numElems, int value, int &nIter) {
  nIter = 0;
  int left = 0, right = numElems - 1;

  while (left <= right) {
    /* cout << left << ' ' << right << endl; */
    nIter++;
    int between = left + (right - left) / 2;

    if (arr[between] == value) {
      return between;
    }

    if (arr[between] < value) {
      left = between + 1;
    } else {
      right = between - 1;
    }
  }
  return -1;
}

void displayArrays(string title, int arr1[], string arr2[], double arr3[],
                   int size) {
  cout << title << ':' << endl;
  cout << string(title.length() + 1, '-') << endl;
  cout << "index" << setw(7) << "netID" << setw(7) << "major"
       << setw(7) << "GPA";
  cout << "index" << setw(7) << "netID" << setw(7) << "major"
       << setw(7) << "GPA";
  cout << endl;

  int i;
  for (i = 0; i < size; i++) {
    cout << setw(5) << i << setw(7) << arr1[i] << setw(7) << arr2[i] << setw(7)
         << fixed << setprecision(2) << arr3[i];
    if (i % 2 != 0) {
      cout << endl;
    }
  }
  if (i % 2 == 0) {
    cout << endl;
  }
}

void printTopNStudents(int arr1[], string arr2[], double arr3[], int size) {
  int n;
  cout << "Enter n: ";
  cin >> n;

  int count = min(n, size);

  cout << "Top " << count << " students are:";
  cout << endl << endl;

  for (int i = count - 1; i > -1; i--) {
    cout << "netID: " << arr1[i] << ", major: " << arr2[i]
         << ", GPA: " 
         << fixed << setprecision(2) 
         << arr3[i] << endl;
  }
}

void displaySearchResults(string title, int iterations, int index,
                          double arr[]) {
  cout << endl;
  cout << "Result of " << title << " search:" << endl;
  cout << "------------------------" << endl;
  if (index == -1) {
    cout << "Student not found" << endl;
  } else {
    cout << "Student found at index " << index << ", GPA is " 
         << fixed << setprecision(2) << arr[index]
         << endl;
  }
  cout << "It took " << iterations << " iterations" << endl;
}

/* Prompt the user for a file name.  

Open the file and read the data to initialize the netID, major and GPA arrays. If the file cannot be opened, print “Could not open file” and “Exiting\n” and terminate.   

Copy netID to sortedNetIDbyGPA, copy GPA to sortedGPAbyGPA and copy major to sortedMajorbyGPA. Sort sortedGPAbyGPA by GPA, while maintaining the parallelism of sortedNetIDbyGPA and sortedMajorbyGPA  

Copy netID to sortedNetIDbyID, copy GPA to sortedGPAbyID and copy major to sortedMajorbyID. Sort sortedNetIDbyID by ID, while maintaining the parallelism of sortedGPAbyID and sortedMajorbyID  

Display the contents of all the arrays. use space of setw(7) between all the different variable

Display the menu of choices, and perform the action selected by the user on the menu (search, list the top n students, or quit). If the user chooses “search”, the main function should call both the linear search and binary search functions, and display the result of both searches, along with the number of iterations.  

The  main  function should loop on displaying the menu as long as the user does not choose to quit. If the user chooses to quit,  the program  should print “Exiting\n” and terminate. */
int main() {

  int netID[NUM_ELMTS];
  string major[NUM_ELMTS];
  double GPA[NUM_ELMTS];

  string buf;
  cout << "Enter file name: ";
  cin >> buf;

  ifstream file;
  file.open(buf);

  if (!file) {
    cout << "Could not open file" << endl;
    cout << "Exiting" << endl;
    return 0;
  }

  // read the data
  int size = 0;
  while (file >> netID[size] >> major[size] >> GPA[size]) {
    size += 1;
  }

  // sorted by gpa declaration
  int sortedNetIDbyGPA[NUM_ELMTS];
  copy(netID, netID + size, sortedNetIDbyGPA);

  double sortedGPAbyGPA[NUM_ELMTS];
  copy(GPA, GPA + size, sortedGPAbyGPA);

  string sortedMajorbyGPA[NUM_ELMTS];
  copy(major, major + size, sortedMajorbyGPA);

  modifiedSortGPA(sortedGPAbyGPA, sortedNetIDbyGPA, sortedMajorbyGPA,
                  size);

  int sortedNetIDbyID[NUM_ELMTS];
  copy(netID, netID + size, sortedNetIDbyID);

  double sortedGPAbyID[NUM_ELMTS];
  copy(GPA, GPA + size, sortedGPAbyID);

  string sortedMajorbyID[NUM_ELMTS];
  copy(major, major + size, sortedMajorbyID);

  modifiedSortID(sortedNetIDbyID, sortedGPAbyID, sortedMajorbyID, size);

  displayArrays("Original arrays", netID, major, GPA, size);
  displayArrays("Arrays sorted by GPA", sortedNetIDbyGPA, sortedMajorbyGPA,
                sortedGPAbyGPA, size);
  displayArrays("Arrays sorted by netID", sortedNetIDbyID, sortedMajorbyID,
                sortedGPAbyID, size);

  while (true) {
    cout << endl;
    cout << "***************\n"
            "Menu of choices\n"
            "***************"
         << endl;

    int choice;
    cout << "1 - List top n students" << endl;
    cout << "2 - Search on a netID" << endl;
    cout << "3 - Quit" << endl;
    cin >> choice;
    
    switch (choice) {
    case 1:
      printTopNStudents(sortedNetIDbyGPA, sortedMajorbyGPA, sortedGPAbyGPA,
                        size);
      break;
    case 2:
      int nID, iterations, linRes, binRes;

      cout << "Enter netID: ";
      cin >> nID;

      linRes = linearSearchID(netID, size, nID, iterations);
      displaySearchResults("linear", iterations, linRes, GPA);
        
      binRes = binarySearchID(sortedNetIDbyID, size, nID, iterations);
      displaySearchResults("binary", iterations, binRes, sortedGPAbyID);

      break;
    case 3:
      cout << "Exiting" << endl;
      return 0;
    default:
      break;
    }
  }

  return 0;
}
