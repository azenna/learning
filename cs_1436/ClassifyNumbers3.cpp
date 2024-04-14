#include <iostream>

using namespace std;

int main(){

    int num, positives = 0, negatives = 0, zeroes = 0, sum = 0, product = 1;
    char buf;

    for(int i = 1; i <= 10; i++){

        cout << "Enter whole number " << i << ": ";
        cin >> num;

        if(num > 0){
            positives++;
            sum += num;
        }
        else if(num < 0){
            negatives++;
            product *= num;
        }
        else {
            zeroes++;
        }
    }

    cout << endl;

    cout << "Of the 10 numbers entered:" << endl;
    cout << "\t" << zeroes << " were 0's." << endl
         << "\t" << negatives << " were negative." << endl
         << "\t" << positives << " were positive." << endl;

    cout << endl;

    cout << "The product of the negative numbers was " << product << '.' << endl;
    cout << "The sum of the positive numbers was " << sum << '.' << endl;
    return 0;
}
