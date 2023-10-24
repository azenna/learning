#include <iostream>
#include <iomanip>
#include <string>
#include <cmath>

using namespace std;

double getSeconds(){
    double seconds;
    cout << "Please enter the time of the fall (in seconds): ";
    cin >> seconds;

    while(seconds < 0){

        cout << "The time must be at least zero." << endl;
        cin >> seconds;

    }
    return seconds;
}

double findEarthFallDist(double seconds){
    const double GRAVITY = 9.81;

    return 0.5 * GRAVITY * seconds * seconds;
}

double findMoonFallDist(double seconds){
    const double GRAVITY = 1.625;

    return 0.5 * GRAVITY * seconds * seconds;
}

void outDistTime(double distance, double seconds, string planet){
    cout << fixed << setprecision(3)
         << "The object traveled " << distance
         << " meters in " << setprecision(1)
         << seconds << " seconds on " << planet << '.' << endl;
}

int main(){
    
    double seconds = getSeconds();

    while(seconds < 0){

        cout << "Please enter a positive value" << endl;

        seconds = getSeconds();
    }

    cout << endl;

    outDistTime(findEarthFallDist(seconds), seconds, "Earth");
    outDistTime(findMoonFallDist(seconds), seconds, "the Moon");

    return 0;
}
