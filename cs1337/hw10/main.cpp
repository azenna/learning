#include "Date.h"
#include <iostream>

using namespace std;

/* This function takes as argument a string representing a date
in the mm/dd/yyyy/hh format and returns the month as an int
The argument string is assumed properly formatted and no input validation
is required
*/
int getMonth(string d) {
  // Function body
  return stoi(d.substr(0, 2));
}

/* This function takes as argument a string representing a date
in the mm/dd/yyyy/hh format and returns the day as an int
The argument string is assumed properly formatted and no input validation
is required
*/
int getDay(string d) {
  // Function body
  return stoi(d.substr(3, 2));
}

/* This function takes as argument a string representing a date
in the mm/dd/yyyy/hh format and returns the year as an int
The argument string is assumed properly formatted and no input validation
is required
*/
int getYear(string d) {
  // Function body
  return stoi(d.substr(6, 4));
}

/* This function takes as argument a string representing a date
in the mm/dd/yyyy/hh format and returns the hour as an int
The argument string is assumed properly formatted and no input validation
is required
*/
int getHour(string d) {
  // Function body
  return stoi(d.substr(11, 2));
}

int main() {
  int month, day, year, hour; // Generic variables to hold data

  const int NUM_DATES_SUBTRACT = 4, NUM_DATES_RELATIONAL = 5;
  string dateArraySubtract[NUM_DATES_SUBTRACT] = {
      "01/01/2097/20", "02/12/2098/00", "02/13/2100/13",
      "12/31/2103/23"}; // Used to test overloaded -
  string dateArrayRelational[NUM_DATES_RELATIONAL] = {
      "01/01/2097/20", "01/01/2097/21", "01/02/2097/20", "02/01/2097/20",
      "01/01/2098/20"}; // Used to test overloaded <, ==, <=

  // Driver for the Date class
  string title = "Overloaded relational operators";
  string underline;
  underline.assign(title.length(), '-');
  cout << title << endl << underline << endl;

  Date d1, d2;
  for (int i = 0; i < NUM_DATES_RELATIONAL;
       i++) // Nested loop to test all the pairwise combinations of d1, d2
    for (int j = 0; j < NUM_DATES_RELATIONAL; j++) {
      month = getMonth(dateArrayRelational[i]);
      day = getDay(dateArrayRelational[i]);
      year = getYear(dateArrayRelational[i]);
      hour = getHour(dateArrayRelational[i]);
      d1.set(month, day, year, hour);
      cout << endl << "============================================\n";
      cout << "d1: ";
      d1.print();
      month = getMonth(dateArrayRelational[j]);
      day = getDay(dateArrayRelational[j]);
      year = getYear(dateArrayRelational[j]);
      hour = getHour(dateArrayRelational[j]);
      d2.set(month, day, year, hour);
      cout << ", d2: ";
      d2.print();
      cout << endl;

      if (d1 < d2)
        cout << "(d1 < d2) ";
      if (d2 < d1)
        cout << "(d2 < d1) ";
      if (d1 == d2)
        cout << "(d2 == d1) ";
      if (d1 <= d2)
        cout << "(d1 <= d2) ";
      if (d2 <= d1)
        cout << "(d2 <= d1) ";
    }

  title = "Overloaded - operator";
  underline.assign(title.length(), '-');
  cout << endl << endl << title << endl << underline << endl;

  for (int i = 0; i < NUM_DATES_SUBTRACT;
       i++) // Nested loop to test all the pairwise combinations of d1, d2
    for (int j = 0; j < NUM_DATES_SUBTRACT; j++) {
      month = getMonth(dateArraySubtract[i]);
      day = getDay(dateArraySubtract[i]);
      year = getYear(dateArraySubtract[i]);
      hour = getHour(dateArraySubtract[i]);
      d1.set(month, day, year, hour);
      cout << endl << "============================================\n";
      cout << "d1: ";
      d1.print();
      month = getMonth(dateArraySubtract[j]);
      day = getDay(dateArraySubtract[j]);
      year = getYear(dateArraySubtract[j]);
      hour = getHour(dateArraySubtract[j]);
      d2.set(month, day, year, hour);
      cout << ", d2: ";
      d2.print();
      cout << endl;
      cout << "d2 - d1 = " << d2 - d1 << " hours" << endl;
    }
  return 0;
}
