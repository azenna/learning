#include <iostream>
#include <cstdlib>

using namespace std;

int main(){

    int a, b, c;

    cout << "Enter the three sides of your triangle: ";
    cin >> a >> b >> c;

    int largest, x, y;

    if(a > max(b, c)){
        largest = a;
        x = b;
        y = c;
    }
    else if(b > max(a, c)){
        largest = b;
        x = a;
        y = c;
    }
    else{
        largest = c;
        x = a;
        y = b;
    }

    if(largest < x + y){
        cout << "Your sides can make a valid traingle!" << endl;
    }
    else {
        cout << "Your sides cannot make a valid triangle! :(" << endl;
    }

}
