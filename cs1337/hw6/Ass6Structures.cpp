#include <algorithm>
#include <fstream>
#include <iomanip>
#include <iostream>

using namespace std;

const int NUM_ELMTS = 18;

struct Student {
  int netID;
  string major;
  double GPA;
};
void modifiedSortGPA(Student array1[], int size);
void modifiedSortID(Student array2[], int size);
tuple<int, int> linearSearch(int id, Student arr[], int size);
tuple<int, int> binarySearch(int id, Student arr[], int size);
int linearSearchID(Student arr[], int size, int id, int &iter);
int binarySearchID(Student arr[], int size, int id, int &iter);
int readStudents(ifstream &file, Student arr[NUM_ELMTS]);
void displayStudent(const Student &student);
void displayStudents(string banner, Student arr[], int size);
void displaySearchMessage(string searchType, Student arr[],
                          tuple<int, int> searchResult);
void displayTopN(int n, Student arrSortGPA[], int size);

/* Prompt the user for a file name.
 Open the file and read the data to initialize the array of structures.  If
 the file cannot be opened, print “Could not open file” and “Exiting\n” and
 terminate. Make the copies and sort the copies Display the contents of the
 arrays Display the menu of choices, and perform the action selected by the
 user on the menu (search, list the top n students, or quit). If the user
 chooses “search”, the main function should call both the linear search and
 binary search functions, and display the result of both searches, along
 with the number of iterations. The  main  function should loop on
 displaying the menu as long as the user does not choose to quit. If the
 user chooses to quit,  the program  should print “Exiting\n” and terminate.
 */
int main() {

  // declare arrays
  Student studArray[NUM_ELMTS];
  Student studArraySortedByGPA[NUM_ELMTS];
  Student studArraySortedByID[NUM_ELMTS];

  // get input file
  string fileName;
  cout << "Enter file name:" << endl;
  cin >> fileName;

  ifstream file(fileName);

  // validate input file
  if (!file) {
    cout << "Could not open file" << endl;
    cout << "Exiting" << endl;
    return 0;
  }

  // read students into array and figure out how many students there are
  int numStudents = readStudents(file, studArray);

  // copy studArray and sort by gp
  copy(studArray, (studArray + numStudents), studArraySortedByGPA);
  modifiedSortGPA(studArraySortedByGPA, numStudents);

  // copy studArray and sort by id
  copy(studArray, (studArray + numStudents), studArraySortedByID);
  modifiedSortID(studArraySortedByID, numStudents);

  // display all three arrays
  displayStudents("Original array", studArray, numStudents);
  displayStudents("Array sorted by GPA", studArraySortedByGPA, numStudents);
  displayStudents("Array sorted by netID", studArraySortedByID, numStudents);

  // menu handling
  int choice = 0;
  do {

    // display menu options
    cout << endl
         << "***************" << endl
         << "Menu of choices" << endl
         << "***************" << endl
         << "1 - List top n students" << endl
         << "2 - Search on a netID" << endl
         << "3 - Quit" << endl;
    cin >> choice;

    // choice handling
    switch (choice) {

    // List n students
    case 1: {
      int n;
      cout << endl << "Enter n:" << endl;
      cin >> n;

      cout << endl;
      displayTopN(n, studArraySortedByGPA, numStudents);
    } break;

    // Binary and linear search by netid
    case 2: {

      int netID;
      cout << "Enter netID:" << endl;
      cin >> netID;

      tuple<int, int> linearResult =
          linearSearch(netID, studArraySortedByID, numStudents);

      cout << endl;
      displaySearchMessage("linear", studArraySortedByID, linearResult);

      tuple<int, int> binaryResult =
          binarySearch(netID, studArraySortedByID, numStudents);

      cout << endl;
      displaySearchMessage("binary", studArraySortedByID, binaryResult);

    } break;
    default:
      break;
    }

    // if the choice is 3 stop the loop
  } while (choice != 3);

  // Exit gracefully
  cout << "Exiting" << endl;
  return 0;
}

/* This function sorts the array of Student structures according to GPA
 */
// Pseudcode:
// sortByGPA(arr, size):
//   return sort(arr, lambda x y: x.GPA < y.GPA)
void modifiedSortGPA(Student array1[], int size) {
  sort(array1, (array1 + size), [](auto &student1, auto &student2) {
    return student1.GPA < student2.GPA;
  });
}

/* This function sorts the array of Student structures according to netID
 */
// Pseudcode:
// sortByID(arr, size):
//   return sort(arr, lambda x y: x.netID < y.netID)
void modifiedSortID(Student array2[], int size) {
  sort(array2, (array2 + size), [](auto &student1, auto &student2) {
    return student1.netID < student2.netID;
  });
}

// Does a linear search for a studnet ID using cpp standard library find_if
// based on the returned pointer maths its why to a result
// Pseudcode:
// linearSearch(id, arr, size):
// i = find(id, arr)
// return (i or -1 if i == size, min(i + 1, size))
tuple<int, int> linearSearch(int id, Student arr[], int size) {

  Student *p = find_if(arr, arr + size,
                       [id](auto &student) { return student.netID == id; });

  return tuple<int, int>((p == arr + size) ? -1 : (p - arr),
                         min(int(p - arr + 1), size));
}

// cool little wrapper to get test case to pass
int linearSearchID(Student arr[], int size, int id, int &iter) {
  tuple<int, int> res = linearSearch(id, arr, size);
  iter = get<1>(res);
  return get<0>(res);
}

// Classic binary search function over student ids
// Pseduocode:
// binarySearch(arr, size, id):
//  lo = 0
//  hi = size - 1
//  iterations = 0
//
//  while lo <= hi:
//      m = (lo + hi) / 2
//      if arr[m].netID < id:
//          lo = m + 1
//      else:
//          hi = m
//
//      iterations = iterations + 1
//  return (lo or -1, iterations)
//
tuple<int, int> binarySearch(int id, Student arr[], int size) {
  int lo = 0, hi = size - 1;
  int m, iterations = 0;
  while (lo < hi) {
    m = (lo + hi) / 2;

    if (arr[m].netID < id) {
      lo = m + 1;
    } else {
      hi = m;
    }
    iterations++;
  }

  // if the element was found return lo for it's index otherwise -1
  if (arr[lo].netID == id) {
    return tuple<int, int>(lo, iterations);
  } else {
    // zybooks requires the +1 lol
    return tuple<int, int>(-1, iterations + 1);
  }
}

// cool little wrapper to get test case to pass
int binarySearchID(Student arr[], int size, int id, int &iter) {
  tuple<int, int> res = binarySearch(id, arr, size);
  iter = get<1>(res);
  return get<0>(res);
}

// reads students to array from open file
// Pseudocode:
// readStudents(file, arr):
//   for i in 0..NUM_ELMTS:
//     line = file.next_line()
//     if(line): arr[i] = parseStudent(line_)
//     else: break
//   return i
int readStudents(ifstream &file, Student arr[NUM_ELMTS]) {
  int i;
  Student student;
  for (i = 0; i < NUM_ELMTS; i++) {
    if (file >> student.netID >> student.major >> student.GPA) {
      arr[i] = student;
    } else {
      break;
    }
  }
  return i;
}

// displays a student see dispalyStudents
void displayStudent(const Student &student) {
  cout << right << setw(7) << student.netID << right << setw(7) << student.major
       << right << setw(7) << fixed << setprecision(2) << student.GPA;
}

// displays student table
void displayStudents(string banner, Student arr[], int size) {
  cout << banner << ':' << endl;
  cout << string(banner.length() + 1, '-') << endl;

  cout << setw(5) << right << "index" << setw(7) << right << "netID" << setw(7)
       << right << "major" << setw(7) << right << "GPA" << setw(7) << right
       << "index" << setw(7) << right << "netID" << setw(7) << right << "major"
       << setw(7) << right << "GPA" << endl;

  for (int i = 0; i < size; i++) {
    if (i % 2 == 0) {
      cout << right << setw(5) << i;
      displayStudent(arr[i]);
    } else {
      cout << right << setw(7) << i;
      displayStudent(arr[i]);
      cout << endl;
    }
  }
  cout << endl;
}

// helper function to print out search messages in a abstracted way
void displaySearchMessage(string searchType, Student arr[],
                          tuple<int, int> searchResult) {

  int ind = get<0>(searchResult);
  string message = "Result of " + searchType + " search:";
  cout << message << endl << string(message.length(), '-') << endl;

  if (ind == -1) {
    cout << "Student not found" << endl;
  } else {
    cout << "Student found at index " << ind << ", major is " << arr[ind].major
         << ", GPA is " << arr[ind].GPA << endl;
  }
  cout << "It took " << get<1>(searchResult) << " iterations" << endl;
}

// function to display the Top N students
// takes an ascending by gpa ordered array and iterates n backwards printing
// things out
void displayTopN(int n, Student arrSortGPA[], int size) {
  n = min(n, size);
  cout << "Top " << n << " students are:" << endl << endl;
  for (int i = (n - 1); i >= 0; i--) {
    cout << "netID: " << arrSortGPA[i].netID
         << ", major: " << arrSortGPA[i].major << ", GPA: " << arrSortGPA[i].GPA
         << endl;
  }
}
