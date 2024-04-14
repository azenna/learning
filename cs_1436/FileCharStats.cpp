#include <iostream>
#include <fstream>
#include <string>
#include <map>

using namespace std;

// Program that provides character statistics for a given file
// Reads a file char by char and counts number of lines, letters, and
// total chars
// If file is empty or doen't exist program provides an error message
// and returns early
int main(){
    
    string fileName;
    cout << "Enter the name of the input file." << endl;
    cin >> fileName;
    cout << endl;

    ifstream file;
    file.open(fileName);

    if(!file.is_open()){
        cout << "Error, unable to open \"" << fileName << "\"." << endl;
        return 0;
    }

    if(file.peek() == ifstream::traits_type::eof()){
        cout << '"' << fileName << "\" was empty." << endl;
        return 0;
    }


    int totalLines = 0, totalChars = 0, totalLetters = 0;

    map<char, int> charCounts;

    for(int i = 0; i < 26; i++){
        charCounts['A' + i] = 0;
    }

    char c;

    while(file >> noskipws >> c){

        if(c == '\n'){
            totalLines += 1;
        }
        if(isalpha(c)){
            totalLetters += 1;
            charCounts[toupper(c)]++;
        }
        
        totalChars += 1;
    }
    if(totalLines == 0){
        totalLines = 1;
    }


    cout << "Lines read = " << totalLines << endl;
    cout << "Characters read = " << totalChars << endl;
    cout << "Letters read = " << totalLetters << endl;
    cout << endl;
    
    cout << "The individual letter totals were:" << endl;
    for(auto it = charCounts.begin(); it != charCounts.end(); it++){
        cout << it->first << "'s = " << it->second << endl;
    } 

    return 0;
}
