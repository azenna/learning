#include <iostream>
#include <fstream>
#include <string>

using namespace std;

class Report {
    public:
        string month;

        Report(string m) {
            month = m;
            rainy = 0;
            cloudy = 0;
            sunny = 0;
        }

        void read30Days(char days[30]){
            for(int i = 0; i < 30; i++){
                char day = days[i];
                if(day == 'R'){
                    rainy += 1;
                } else if(day == 'S'){
                    sunny += 1;
                } else if(day == 'C'){
                    cloudy += 1;
                }
            }
        }

        void report(){
            cout << "In the mont of " << month << ':' << endl;
            cout << "   " << rainy << " days were rainy." << endl;
            cout << "   " << sunny << " days were sunny." << endl;
            cout << "   " << cloudy << " days were cloudy." << endl;
        }
        
        Report* moreRainy(Report* other){
            if(rainy > other->rainy){
                return this;
            } else{
                return other;
            }
        }

    private:
        int rainy;
        int cloudy;
        int sunny;
};


int main(){

    const int ROWS = 3;
    const int COLUMNS = 30;

    char weatherConditions[ROWS][COLUMNS];

    ifstream file;
    file.open("RainOrShine.txt");

    for(int i = 0; i < ROWS; i++){
        for(int j = 0; j < COLUMNS; j++){
            file >> weatherConditions[i][j];
        }
    }

    Report june("June");
    june.read30Days(weatherConditions[0]);

    Report july("July");
    july.read30Days(weatherConditions[1]);

    Report august("August");
    august.read30Days(weatherConditions[2]);

    Report* mostRainy = june.moreRainy(&july)->moreRainy(&august);

    june.report();
    july.report();
    august.report();

    cout << mostRainy->month << " had the most rainy days." << endl; 

    return 0;
}
