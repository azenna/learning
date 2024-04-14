#include "Date.h"
#include <iostream>
using namespace std;

void Date::set(int m, int d, int y, int h) {
  month = m;
  day = d;
  year = y;
  hour = h;
}

bool Date::operator<(const Date &rhs) {
  // Comparison based on year, month, day, and hour
  if (year < rhs.year)
    return true;
  else if (year > rhs.year)
    return false;

  if (month < rhs.month)
    return true;
  else if (month > rhs.month)
    return false;

  if (day < rhs.day)
    return true;
  else if (day > rhs.day)
    return false;

  return hour < rhs.hour;
}

bool Date::operator==(const Date &rhs) {
  return (year == rhs.year && month == rhs.month && day == rhs.day &&
          hour == rhs.hour);
}

bool Date::operator<=(const Date &rhs) { return (*this < rhs || *this == rhs); }

int Date::operator-(const Date &rhs) {
  int daysBetween[] = {0,   31,  59,  90,  120, 151, 181,
                       212, 243, 273, 304, 334, 365};

  int tHours = (365 * (year - 1) + daysBetween[month - 1] + day) * 24 + hour;
  int rHours =
      (365 * (rhs.year - 1) + daysBetween[rhs.month - 1] + rhs.day) * 24 +
      rhs.hour;

  if (((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) && month > 2) {
    tHours += 24;
  }

  if (((rhs.year % 4 == 0 && rhs.year % 100 != 0) || rhs.year % 400 == 0) &&
      rhs.month > 2) {
    rHours += 24;
  }

  return tHours - rHours;
}

void Date::print() {
  string months[] = {"",        "January",  "February", "March",  "April",
                     "May",     "June",     "July",     "August", "September",
                     "October", "November", "December"};
  cout << months[month] << " " << day << ", " << year << ", " << hour << ":00";
}
