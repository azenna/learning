#include <iostream>
#include <string>
#include <fstream>
#include <iomanip>

using namespace std;

int main(){
    
    string fileName;
    cout << "Please enter the input file name." << endl;
    cin >> fileName;

    ifstream inputFile;
    inputFile.open(fileName);

    if(inputFile){
        
        ofstream outFile;
        outFile.open("saleschart.txt");

        if(outFile){
            
        if(inputFile.peek() != ifstream::traits_type::eof()){
            outFile << "SALES BAR CHART" << endl;
            outFile << "(Each * equals 5,000 dollars)" 
                    << endl;
        }

            int store, sales;

            while(inputFile >> store >> sales){
                if(store < 1 || store > 99){
                    cout << store << ' '
                         << "is not in the range 1 through 99." 
                         << endl;
                    continue;
                }

                if(sales < 0){
                    cout << "Skipped store #"
                         << store << '.' << endl;
                    continue;
                }

                outFile << "Store " 
                        << setfill(' ')
                        << setw(2) << store 
                        << ": " << string(sales / 5000, '*')
                        << endl;
            }
        } else {
            cout << "Failed to open saleschart.txt" 
                 << endl;
        }
    } else {
        cout << '"' << fileName 
             << '"' << " could not be opened."
             << endl;
    }

    return 0;
}
