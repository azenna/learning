#include <iostream>
#include <string>
#include <cctype>
#include <cstdlib>
#include <ctime>

using namespace std;

const string specials = "!@#$%^&*+:;";

//returns a random character from all allowed ones.
char randomChar() {
        int r = rand() % (26+26+10+specials.length());
        if (r < 26)
            return (char) (r + 'a'); //lower case
        if (r < 52)
            return (char) (r - 26 + 'A'); //upper case
        if (r < 62)
            return (char) (r - 52 + '0'); //digit

        return specials[r-62]; //special char
}

string generatePassword(int minLength, int maxLength, int minLower, int minUpper,
                        int minNumber, int minSpecial) {
    if((minLower + minUpper + minNumber + minSpecial) > maxLength
        || minLength > maxLength){
      return "invalid";
    }

    int lower = 0, upper = 0, number = 0, special = 0;
    string buf;

    while(lower < minLower || upper < minUpper || number < minNumber || special < minSpecial){
      char c = randomChar();
      if(ispunct(c) && special < minSpecial){
        special += 1;
        buf += c;
      }       
      if(islower(c) && lower < minLower){
        lower += 1;
        buf += c;
      }      
      if(isupper(c) && upper < minUpper){
        upper += 1;
        buf += c;
      }
      if(isdigit(c) && number < minNumber){
        number += 1;
        buf += c;
      }
    }
    while(buf.length() < minLength){
      char c = randomChar();
      buf += c;
    }
    return buf;
}

int main() {
   
    int minL, maxL, lower, upper, digits, specials;
    cout << "Enter minL, maxL, lower, upper, digits, specials values: " << endl;
    cin >> minL>> maxL>> lower>> upper>> digits>> specials;
    cout  <<  generatePassword(minL, maxL, lower, upper, digits, specials) << endl;
    cout <<  generatePassword(8, 10, 2, 2, 2, 2);

    return 0;
}
