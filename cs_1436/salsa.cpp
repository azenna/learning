#include <iostream>
#include <string>
#include <cstdlib>
#include <map>

using namespace std;

int main(){
    string salsas[] = 
        { "mild"
        , "medium"
        , "sweet"
        , "hot"
        , "zesty" };
    int sold[5];

    for(int i = 0; i < 5; i++){
        do {
            cout << "Enter # of jars sold for " << salsas[i] << ": ";
            cin >> sold[i];

            if(sold[i] < 0){
                cout << "Jars sold cannot be negative." << endl;
            }

        } while(sold[i] < 0);
    }
    
    int totalSales = 0;

    int highestSale = sold[0];
    string highestSaleSalsa = salsas[0];

    int lowestSale = sold[0];
    string lowestSaleSalsa = salsas[0];

    for(int i = 0; i < 5; i++){

        int s = sold[i];
        string salsa = salsas[i];

        cout << "# of jars " << salsa << " that was sold: " << s << endl;

        totalSales += s;

        if(s > highestSale){
            highestSale = s;
            highestSaleSalsa = salsa;
        }
        if(s < lowestSale){
            lowestSale = s;
            lowestSaleSalsa = salsa;
        } 
    }

    cout << endl;
    cout <<  "Total sales: " << totalSales << endl;
    
    cout << endl;
    cout << "Type with the highest sale: " << highestSaleSalsa << endl;
    cout << "Type with the lowest sale: " << lowestSaleSalsa << endl;
}
