#include <iostream>

using namespace std;

int main(){

    double priceList[] = 
        { 9.99
        , 2.99
        , 12.50
        , 15.30
        , 24.50
        , 39.99
        , 5.99
        , 39.99
        , 5.99
        , 3.99
        , 4.50
        , 7.99 };
    int priceLength = sizeof(priceList)/sizeof(priceList[0]);
    
    double spendingLimit = 50.0;
    double total = 0.0;

    for(int i = 0; i < 12; i++){

        double price = priceList[i];

        if(total + price > spendingLimit){
            break;
        }
        cout << price << ' '; 
        total += priceList[i];
    }
    cout << "Total " << total << endl;

    total = 0.0;
    for(int i = 0; i < 12; i++){

        double price = priceList[i];

        if(total + price > spendingLimit){
            continue;
        }
        cout << price << ' '; 
        total += priceList[i];
    }
    cout << "Total " << total << endl;


    return 0;
}
