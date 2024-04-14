#include <iostream>

using namespace std;

int getValue(){
    int x;
    cin >> x;

    if(x >= 0){
        return x;
    }
}

float getMarkup(){
    float x;
    cin >> x;

    if(x >= 0){
        return x;
    }
}

void computePrintRetail(double value, double markup){
    cout << value * (1.0 + (markup / 100.0));
}

int main() {

    int value = getValue();
    double markup = getMarkup();

    computePrintRetail(value, markup);
    
    return 0;
}
