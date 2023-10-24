#include <iostream>
#include <iomanip>

using namespace std;

// Program that takes a series of grades terminated by a -999
// finds the average and lists the scores below average
int main(){

    int grades[120];
    int gradesLength = 0;

    cout << "Enter the first score or -999 to end input: ";

    for(int i = 0; i < 120; i++){
        cin >> grades[i];

        if(grades[i] == -999){
            if(i == 0){
                cout << "No scores were entered." << endl;
                return 0;
            }
            break;
        }

        gradesLength += 1;
    }

    float average = 0;

    for(int i = 0; i < gradesLength; i++){
        average += grades[i];
    }

    average /= gradesLength;

    int belowAverage[119];
    int belowAverageLength = 0;
    
    for(int i = 0; i < gradesLength; i++){
        if(grades[i] < average){
            belowAverage[belowAverageLength] = grades[i];
            belowAverageLength++;
        }
    }


    cout << "The average of the scores is: "
         << fixed << setprecision(1) << average
         << '.' << endl;

    if(belowAverageLength == 0){
        return 0;
    }
    cout << "The scores below the average were: ";
    for(int i = 0; i < belowAverageLength; i++){
        cout << belowAverage[i] << ' ';
    }
    cout << endl;


    return 0;
}
