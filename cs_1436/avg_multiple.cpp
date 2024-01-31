#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main(){

    int toRead;
    cout << "How many files do you have? ";
    cin >> toRead;

    cout << "What are the names of your " << toRead << " files?" << endl;

    vector<int> table[toRead];
    string str;

    for(int i = 0; i < toRead; i++){
        ifstream file;
        string name;

        cout << "File " << i + 1 << ": ";
        cin >> name;
        file.open(name);

        if(!file){
            cout << "File " << name << " does not exist try again" << endl;
            i -= 1;
            continue;
        }

        while(file >> str){
            table[i].push_back(stoi(str));
        }
    }

    float avgs[table[0].size()];

    for(int i = 0; i < table[0].size(); i++){
        float avg = 0.0;
        for(int j = 0; j < toRead; j++){
            avg += table[j][i];
        }
        avg /= toRead;
        avgs[i] = avg;
    }

    cout << endl;
    cout << "Your averages across " << toRead 
         << " files each containing " << table[0].size() 
         << " lines are: " << endl;

    for(float avg: avgs){
        cout << avg << endl;
    }

    return 0;
}
