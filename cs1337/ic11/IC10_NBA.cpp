#include <cstdint>
#include <fstream>
#include <iomanip>
#include <iostream>

using namespace std;

typedef struct {
  int pscores;
  int age;
  int steals;
  int fouls;
  int blocks;
  int rebounds;
  string pname;
} Nbastats;

enum Field {
  Score,
  Age,
  Steal,
  Foul,
  Block,
  Rebound,
};

string fieldString(Field f){
  switch (f) {
    case Score:
      return "score";
      break;
    case Age:
      return "age of team";
      break;
    case Steal:
      return "steals";
      break;
    case Foul:
      return "fouls";
      break;
    case Block:
      return "blocks";
      break;
    case Rebound:
      return "rebounds";
      break;
    default:
      break;
  }
  return "";
}
int nbaStatField(Nbastats &stats, Field f){
  switch(f){
    case Score:
      return stats.pscores;
      break;
    case Age:
      return stats.age;
      break;
    case Steal:
      return stats.steals;
      break;
    case Foul:
      return stats.fouls;
      break;
    case Block:
      return stats.blocks;
      break;
    case Rebound:
      return stats.rebounds;
      break;
defualt:
      break;
  }
  return -1;
}



void displayStats(Nbastats& stats){
  cout << left << setw(16) << stats.pname
    << left << setw(8) << stats.age
    << left << setw(8) << stats.pscores
    << left << setw(8) << stats.rebounds
    << left << setw(8) << stats.steals
    << left << setw(8) << stats.blocks
    << left << setw(8) << stats.fouls
    << endl;
}

const int NUM_PLAYERS = 50;
const int NAME_COL_WIDTH = 16;
// readFile returns number of elements read.
int readFile(Nbastats player[]){
  ifstream file("nbastats.txt");

  if(!file){
    cout << "Failed to open file" << endl;
    return -1;
  }

  string buf;
  getline(file, buf);

  int count = 0;

  while(true){
    Nbastats stats;
    if(file >> stats.pname
        >> stats.age
        >> stats.pscores
        >> stats.rebounds
        >> stats.steals
        >> stats.blocks
        >> stats.fouls){
      player[count] = stats;
      count++;
    }
    else break;
  }

  file.close();

  return count;
}
double getAvg(Nbastats data[], int asize, Field f){
  int total = 0;
  for(int i = 0; i < asize; i++){
    total += nbaStatField(data[i], f);
  }
  return double(total) / asize;
}
int getMax(Nbastats data[], int asize, Field f){
  int m = 0;
  int j = 0;
  for(int i = 0; i < asize; i++){
    int stat = nbaStatField(data[i], f);
    if(stat > m){
      m = stat;
      j = i;
    }
  }
  return j;
}
int getMin(Nbastats data[], int asize, Field f){
  int m = INT32_MAX;
  int j = 0;
  for(int i = 0; i < asize; i++){
    int stat = nbaStatField(data[i], f);
    if(stat < m){
      m = stat;
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

  cout << "Name		age	Points	Rebound	Steals	Blocks	PF\n";
  /* cout << left << setw(16) << "Name" */
  /*      << left << setw(8) << "age" */
  /*      << left << setw(8) << "Points" */
  /*      << left << setw(8) << "Rebound" */
  /*      << left << setw(8) << "Steals" */
  /*      << left << setw(8) << "Blocks" */
  /*      << left << "PF" << endl; */
  for (i = 0; i < count; i++)
    displayStats(player[i]);

  cout << endl;

  
  while(true) {
    cout << "Enter the field for getting average, min and max:" << endl;
    cout << "Please pick one item from the menu:" << endl;

    int choice = 0;

    cout << "Enter " << Score << " for Scores" << endl;
    cout << "Enter " << Age << " for Age" << endl;
    cout << "Enter " << Steal << " for Steals" << endl;
    cout << "Enter " << Foul << " for Fouls" << endl;
    cout << "Enter " << Block << " for Blocks" << endl;
    cout << "Enter " << Rebound << " for Rebounds" << endl;
    cout << "Enter 6 for quit: " << endl;
    cin >> choice;

    if(choice == 6){
      break;
    }

    // calling functions max, min and average and printing the results

    Field choiceField = static_cast<Field>(choice);
    string fldStr = fieldString(choiceField);
    double average = getAvg(player, count, choiceField);

    cout << "The average " << fldStr << " is " << average << endl;

    minIndex = getMin(player, count, choiceField);
      maxIndex = getMax(player, count, choiceField);

    if(choiceField == Age){
      cout << "The player with minimum age is " << player[minIndex].pname << " "
        << " = " << nbaStatField(player[minIndex], choiceField) << endl;

      cout << "The player with maximum age is " << player[maxIndex].pname << " "
        << " = " << nbaStatField(player[maxIndex], choiceField) << endl;
    } else {
      cout << "Minimum " << fldStr << " by " << player[minIndex].pname << " "
        << " = " << nbaStatField(player[minIndex], choiceField) << endl;

      cout << "Maximum " << fldStr << " by " << player[maxIndex].pname << " "
        << " = " << nbaStatField(player[maxIndex], choiceField) << endl;

    }

    cout << endl;
  } 


  return 0;
}
