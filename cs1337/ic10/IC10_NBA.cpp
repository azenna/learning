#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>

using namespace std;

typedef struct {
  string name;
  int age;
  int points;
  int rebound;
  int steal;
  int blocks;
  int pf;
} Nbastats;

void displayStats(Nbastats& stats){
  cout << setw(16) << stats.name
    << left << setw(8) << stats.age
    << left << setw(8) << stats.points
    << left << setw(8) << stats.rebound
    << left << setw(8) << stats.steal
    << left << setw(8) << stats.blocks
    << left << setw(8) << stats.pf
    << endl;
}

const int NUM_PLAYERS = 50;
const int NAME_COL_WIDTH = 16;
// readFile returns number of elements read.
int readFile(Nbastats player[]){
  string name;
  cout << "Enter file name: ";
  cout << endl;
  cin >> name;

  ifstream file(name);

  if(!file){
    cout << "Failed to open file" << endl;
    return -1;
  }

  string buf;
  getline(file, buf);

  int count = 0;

  while(true){
    Nbastats stats;
    if(file >> stats.name
        >> stats.age
        >> stats.points
        >> stats.rebound
        >> stats.steal
        >> stats.blocks
        >> stats.pf){
      player[count] = stats;
      count++;
    }
    else break;
  }

  file.close();

  return count;
}
double getAvg(int data[], int asize){
  int total = 0;
  for(int i = 0; i < asize; i++){
    total += data[i];
  }
  return double(total) / asize;
}
int getMax(int data[], int asize){
  int m = 0;
  int j = 0;
  for(int i = 0; i < asize; i++){
    if(data[i] > m){
      m = data[i];
      j = i;
    }
  }
  return j;
}
int getMin(int data[], int asize){
  int m = INT32_MAX;
  int j = 0;
  for(int i = 0; i < asize; i++){
    if(data[i] < m){
      m = data[i];
      j = i;
    }
  }
  return j;
}

int main() {
  Nbastats player[NUM_PLAYERS];

  int i, minIndex, maxIndex;

  // Write your code to print the header of the file

  int count = readFile(player);
  if (count == -1)
    return -1;
  cout << left << setw(16) << "Name"
       << left << setw(8) << "age"
       << left << setw(8) << "Points"
       << left << setw(8) << "Rebound"
       << left << setw(8) << "Steals"
       << left << setw(8) << "Blocks"
       << left << setw(8) << "PF" << endl;
  for (i = 0; i < count; i++)
    displayStats(player[i]);

  int pointsArray[count];
  for (int i = 0; i < count; i++)
    pointsArray[i] = player[i].points;

  // calling functions max, min and average and printing the results
  double average = getAvg(pointsArray, count);
  cout << "\nThe average score is " << average << endl;

  minIndex = getMin(pointsArray, count);
  cout << "Minimum score by " << player[minIndex].name << " "
       << " = " << player[minIndex].points << endl;

  maxIndex = getMax(pointsArray, count);
  cout << "Maximum score by " << player[maxIndex].name << " "
       << " = " << player[maxIndex].points << endl;

  return 0;
}
