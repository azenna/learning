#include <iostream>
#include <algorithm>
#include <tuple>
#include <fstream>
using namespace std;

const int MAX_CANDIDATES = 10;
const int MAX_COUNTIES = 10;


//file reading
bool readContents(int argSource[][MAX_COUNTIES], int &argPpl, int &argPlaces){
    ifstream inputFile;
    inputFile.open("data_voter_2D.txt");
    if(!inputFile){
        inputFile.close();
        return false; //denotes that the file could not be opened
    }
    //control here implies that file has been opened successfully.
    inputFile >> argPlaces >> argPpl;

    for(int i=0; i<argPpl; i++){
        for(int j=0; j<argPlaces; j++){
            inputFile >> argSource[i][j];
        }
    }
    inputFile.close();
    return true;    //file was opened and contents loaded into the array
}

void printData(int argSource[][MAX_COUNTIES],int argPpl, int argPlaces){
        for(int i=0; i<argPpl; i++){
            for(int j=0; j<argPlaces; j++){
                    cout << argSource[i][j] << " ";
            }
            cout << endl;
        }
}

void getTotalForCounty(int argSource[][MAX_COUNTIES],int argPpl, int argCounty, int &argTotal){
        argTotal = 0;   //accumulator
        for(int i=0; i<argPpl; i++){
            argTotal += argSource[i][argCounty];
        }
}

void getTotalForCandidate(int argSource[], int argNumPlaces, int &argTotal){
    argTotal = 0;   //accumulator
    for(int i=0; i<argNumPlaces; i++){
        argTotal += argSource[i];
    }
}

tuple<int, int> enumeratedMaximum(int arr[], int size){
    tuple<int, int> tup;
    tup = make_tuple(0, 0);

    for(int i = 0; i < size; i++){
        tup = max(
            tup, 
            make_tuple(i, arr[i]),
            [](auto a, auto b) {return get<1>(a) < get<1>(b); });
    }

    return tup;
}

int main(){
    int data[MAX_CANDIDATES][MAX_COUNTIES];
    int numPpl, numPlaces;

    //reading the file contents
    bool fileReadStatus = readContents(data, numPpl, numPlaces);
    if( fileReadStatus == false){
        cout << "File not found" << endl;
        return(0);
    }

    printData(data,numPpl, numPlaces );

    int candidateTotal[numPpl]; //store total votes got for each candidate
    int countyTotal[numPlaces]; //to store total votes registered in each county

    //compute total for each candidate
    for(int i=0; i<numPpl; i++){
        getTotalForCandidate(data[i], numPlaces, candidateTotal[i] );
        cout << "Total for candidate " << i+1 << " : " << candidateTotal[i] << endl;
    }

    //compute total for each county
    for(int i=0; i<numPlaces; i++){
       getTotalForCounty(data, numPpl,i, countyTotal[i]);
    cout << "Total for county " << i+1 << " : " << countyTotal[i] << endl;
    }

    //FINISH the code to find the candidate with highest vote
    //  and the county with max registrations
    //finding max in a 1D array has been done in class earlier
    //  use the example that finds max & min in an airline - that was fidning max & min in 1D array
    //  here it will be finding a county with max & candidate with max votes in a 2D
    
    int candMax = get<0>(enumeratedMaximum(candidateTotal, numPpl)) + 1;
    int countyMax = get<0>(enumeratedMaximum(countyTotal, numPlaces)) + 1;

    cout << "Candidate " << candMax << " won!!!" << endl;
    cout << "County " << countyMax << " has the most voter tournout!!!" << endl;

    return 0;
}
