#include <fstream>
#include <iomanip>
#include <iostream>
#include <string>

using namespace std;

#define INFONUM 255

// patients structure definition
typedef struct {
  string id;
  string first;
  string last;
  string bpu;
  string bpl;
  string pulse;
} Patient;

void displayPateint(Patient p){
  cout << left << setw(4) << p.id
  << left << setw(10) << p.first
  << left << setw(10) << p.last
  << left << setw(4) << p.bpu
  << left << setw(4) << p.bpl
  << left << setw(4) << p.pulse << endl;
}

int main() {
  string fileName;
  cout << "Enter filename: " << endl;
  cin >> fileName;

  ifstream file(fileName);

  if(!file){
    cout << "Could not open file" << endl;
    cout << "Exiting" << endl;
    return 0;
  }
  
  string line;
  int fileLines = 0;
  while(getline(file, line)){
    fileLines += 1;
  }

  file.clear();
  file.seekg(0);

  Patient* patients = new Patient[fileLines];
 
  getline(file, line);

  for(int i = 0; i < fileLines; i++){
    Patient patient;
    file >> patient.id;
    file >> patient.first;
    file >> patient.last;
    file >> patient.bpu;
    file >> patient.bpl;
    file >> patient.pulse;
    patients[i] = patient;
  }
  
  cout << left << setw(4) << "ID"
  << left << setw(10) << "FN"
  << left << setw(10) << "LN"
  << left << setw(4) << "BPU"
  << left << setw(4) << "BPL"
  << left << setw(4) << "Pulse" << endl;

  for(int i = 0; i < fileLines; i++){
    displayPateint(patients[i]);
  }

  delete[] patients;

  file.close();
  return 0;
} 
