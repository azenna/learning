#include <iostream>
#include <algorithm>

using namespace std;

int main() {

    int num;
    int mx = 0;

    for(int i = 0; i < 4; i++){
        int acc = 0;
        for(int j = 0; j < 4; j++){
            cin >> num;
            acc += num;
        }
        mx = max(mx, acc);
    }

    cout << "The maximum accumulated row is: " << mx << endl;

    return 0;
}
