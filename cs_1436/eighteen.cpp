#include <iostream>

using namespace std;

double computeAverage(double grades[], int gradesSize){
    double total = 0;

    for(int i = 0; i < gradesSize; i++){
        total += grades[i];
    }

    return total / gradesSize;
}

char findLetterGrade(double avg){
    if(avg >= 90.0){
        return 'A';
    } else if(avg >= 80.0){
        return 'B';
    } else if(avg >= 70.0){
        return 'C';
    } else if(avg >= 60.0){
        return 'D';
    } else {
        return 'F';
    }
}

void printOutput(int ids[], double avgs[], char letters[], int size){
    for(int i = 0; i < size; i++){
        cout << "Student " << ids[i] 
             << " with avg " << avgs[i]
             << " receive a letter grade of: " << letters[i] << endl;
    }
}

int main(){
    const int GRADES = 3;
    const int STUDENTS = 5;

    int ids[STUDENTS] = {110, 131, 120, 113, 155};

    double grades[STUDENTS][GRADES] = {
        {100, 100, 100},
        {85, 80, 75},
        {75, 65, 55},
        {30, 20, 35},
        {75, 75, 75},
    };

    double avgs[STUDENTS];
    char letters[STUDENTS];

    for(int i = 0; i < STUDENTS; i++){
        avgs[i] = computeAverage(grades[i], GRADES);
        letters[i] = findLetterGrade(avgs[i]);
    }

    printOutput(ids, avgs, letters, STUDENTS);

    return 0;
}
