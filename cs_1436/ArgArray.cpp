#include <iostream>

using namespace std;

void computePrice(int source[], double price[], int size){
    for(int i = 0; i < size; i++){
        int age = source[i];
        double pri = 12.0;

        if(age <= 5){
            pri = 0.0;
        } else if(age <= 10){
            pri = 8.0;
        } else if(age >= 19.0 && age <= 64.0){
            pri = 20.0;
        }
        price[i] = pri;
    }
}

double computeTotal(double source[], int size){
    double total = 0.0;
    for(int i = 0; i < size; i++){
        total += source[i];
    }
    return total;
}

void printValues(double source[], int size){
    for(int i = 0; i < size; i++){
        cout << source[i] << ' ';
    }
    cout << endl;
}
void printValues(int source[], int size){
    for(int i = 0; i < size; i++){
        cout << source[i] << ' ';
    }
    cout << endl;
}

int main(){
    int ages[] = {36, 5, 3, 45, 10, 12, 70, 50, 20, 18};
    const int AGES_LEN = sizeof(ages)/sizeof(int);

    double prices[AGES_LEN];

    computePrice(ages, prices, AGES_LEN);

    printValues(ages, AGES_LEN);
    printValues(prices, AGES_LEN);

    cout << "Total: " << computeTotal(prices, AGES_LEN) << endl;

    return 0;
}
