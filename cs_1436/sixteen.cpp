#include <iostream>

using namespace std;


int main(){
    const int NUM_EMPLOYEES = 7;

    long int employeeIds[] = {
        5658845,
        4520125,
        7895122,
        8777541,
        8451277,
        1302850,
        7580489,
    };
    
    int hours[NUM_EMPLOYEES];
    double payRate[NUM_EMPLOYEES];
    double wages[NUM_EMPLOYEES];

    for(int i = 0; i < NUM_EMPLOYEES; i++){


        do {
            cout << "Enter employee " << employeeIds[i]
                 << " worked hours: " << endl; 

            cin >> hours[i];

            if(hours[i] < 0){
                cout << "Hours cannot be less than 0." << endl;
            }
        } while(hours[i] < 0);

        do {
            cout << "Enter employee " << employeeIds[i]
                 << " pay rate: " << endl; 

            cin >> payRate[i];

            if(payRate[i] < 15.0){
                cout << "Pay rate cannot be less tahn 15.0." << endl;
            }
        } while(payRate[i] < 15.0);

    }

    for(int i = 0; i < NUM_EMPLOYEES; i++){
        wages[i] = hours[i] * payRate[i];

        cout << employeeIds[i] << ' ' << wages[i] << endl;
    }
  
    return 0;
}
