#include <iostream>
#include <cstdlib>
#include <iomanip>

using namespace std;

// Handles input from user takes refrences to a number of spools
// the discount percentage, a char that stores whether the order uses custom shiiping
// and a shipping values, stores user input and returns nothing
void getOrder(int &spools, double &discount, char &cship, double &shipVal){

    while(true){
        cout << "Please enter the number of spools ordered: ";
        cin >> spools;

        if(spools >= 1){
            break;
        } else {
            cout << "Spools must be at least one." << endl;
        }
    }

    while(true){

        cout << "Enter the discount percentage for the customer: ";
        cin >> discount;

        if(discount >= 0.0){
            break;
        } else {
            cout << "The percentage cannot be negative." << endl;
        }
    }

    while(true){
        cout << "Does the order include custom shipping and handling charges?"
                " [Enter Y for Yes or N for No]: ";
        cin >> cship;
        cship = toupper(cship);

        if(cship == 'Y' || cship == 'N'){
            break;
        } else {
            cout << "\nError, invalid response. The response should be Y for Yes or N for No." << endl;
        }
    }


    if(cship == 'Y'){
        while(true){
            cout << "Enter the shipping and handling charge: ";
            cin >> shipVal;

            if(shipVal >= 0.0){
                break;
            } else {
                cout << "\nError, invalid charges entered. Shipping and handling cannot be negative." << endl;
            }
        }
    } else {
        shipVal = 15.0;
    }
}

// Takes a number of spools and a discount percentage
// and calculates the orders subtotal
double calculateSpoolCharges(int spools, double discount){
    return spools * ((100.0 - discount) / 100.0) * 134.95;
}

// takes a refrence to a instock variable
// and stores how many spools are instock
// reutnrs void
void getInStock(int &instock){
    while(true){
        cout << "Enter the number of spools in stock: ";
        cin >> instock;

        if(instock >= 0){
            break;
        } else {
            cout << "The number of spools cannot be negative." << endl;
        }
    }
}

// Function to output the order summary
// Takes number of spools, how many spools are instock,
// the discount %, and what shipping value to use and ouputs
// a formatted order summary
void orderSummary(int spools, int instock, double discount, double shipVal){

    int shipped = min(instock, spools);
    double subtotal = calculateSpoolCharges(shipped, discount);
    double shipping = shipped * shipVal;

    cout << endl;
    cout << "\t\tOrder Summary" << endl;
    cout << string(30, '=') << endl;
    
    if(instock < spools){
        cout << spools - instock << " spools are on back order." << endl;
    }

    cout << shipped << " spools are ready to ship." << endl;

    cout << "The charges for " << shipped << " spools ";

    if(discount > 0.0){
        cout << "(including a " 
             << fixed << setprecision(1) << discount << "% discount)";
    }
    cout << ": $" << fixed << setprecision(2) << subtotal << endl;

    cout << "Shipping and handling for " << shipped << " spools: $"
         << fixed << setprecision(2) << shipping << endl;

    cout << "The total charges (incl. shipping & handling): $"
         << fixed << setprecision(2) << subtotal + shipping << endl;

    cout << endl;

    cout << "Thank you, please shop again." << endl;
}

int main(){
    int spools, instock;
    char cship;
    double discount, shipVal;

    getOrder(spools, discount, cship, shipVal);
    getInStock(instock);

    orderSummary(spools, instock, discount, shipVal);

    return 0;
}
