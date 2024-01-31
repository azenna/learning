#include <iostream>
#include <algorithm>

using namespace std;

int main(){
    
    int payrate;
    cout << "Input hourly pay rate: ";
    cin >> payrate;

    if(payrate < 0){
        cout << "Invalid input. Payrate cannot be negative" << endl;
        return 0;
    }

    int hours;
    cout << "Input # of hours: ";
    cin >> hours;

    if(hours < 0){
        cout << "Invalid input. Hours cannot be negative" << endl;
        return 0;
    }

    int overtime_hours = max(hours - 40, 0);
    hours -= overtime_hours;
    overtime_hours = min(overtime_hours, 10);

    cout << "Regular hours: " << hours
         << " Overtime hours: " << overtime_hours
         << endl;

    cout << "Your weekly pay: " 
         << payrate * hours + payrate * 1.5 * overtime_hours << endl;

    return 0;
}
