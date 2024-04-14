#include <iostream>
#include <string>

using namespace std;

int main(){

    int myValues[5];
    int total = 0;

    for(int i = 0; i < 5; i++){
        cin >> myValues[i];
        total += myValues[i];
        cout << total << endl;
    }

    return 0;
}
