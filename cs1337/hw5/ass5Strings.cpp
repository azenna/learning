#include <algorithm>
#include <cassert>
#include <cctype>
#include <fstream>
#include <iostream>

using namespace std;

/* Returns true if the string is a valid price, false otherwise
 */
bool isValidPrice(string);

/* Takes as reference parameter a string to be tokenized and returns the first
token found Returns the empty string if no token is found The function deletes
any leading delimiter and the first token found from the original string
Tokenization is based on a delimiter, where a delimiter is the '\t' (tab) , '  '
(space), ‘\n’ (new line) or ‘\r’ (carriage return)  character Example: if the
string s  is "\t abcd\t\t 345\t ^7$ ", the function returns "abcd" as the first
token found, and modifies the string s to become "\t\t 345\t ^7$ "
*/
string tokenize(string &);

// Checks if any value in string is punctuation
bool any_punct(string &);

// general purpose test suite
void test();

int main() {
  test();

  string fileName;
  cout << "Enter input file:" << endl;
  cin >> fileName;

  ifstream file(fileName);

  cout << "Checking " << fileName << endl;
  cout << string(fileName.length() + 9, '-') << endl;

  bool invalid = false;

  string line;
  while (getline(file, line)) {
    cout << endl;
    string token = tokenize(line);
    int counter = 0;
    while (!token.empty()) {

      cout << "Token #" << 1 + counter << " is " << token << ", ";

      switch (counter) {
      case 0:
        if (any_punct(token)) {
          cout << "PLU is invalid" << endl;
          invalid = true;
        } else {
          cout << "PLU is valid" << endl;
        }
        break;
      case 1:
        if (any_punct(token)) {
          cout << "Product name is invalid" << endl;
          invalid = true;
        } else {
          cout << "Product name is valid" << endl;
        }
        break;
      case 2:
        if (token != "1" && token != "0") {
          cout << "Sales type is invalid" << endl;
          invalid = true;
        } else {
          cout << "Sales type is valid" << endl;
        }
        break;
      case 3:
        if (isValidPrice(token)) {
          cout << "Price is valid" << endl;
        } else {
          cout << "Price is invalid" << endl;
          invalid = true;
        }
        break;
      case 4:
        if (any_punct(token)) {
          cout << "Inventory is invalid" << endl;
          invalid = true;
        } else {
          cout << "Inventory is valid" << endl;
        }
        break;
      case 5:
        cout << "Too many items in record" << endl;
        invalid = true;
        break;
      default:
        break;
      }

      if (invalid) {
        break;
      }

      token = tokenize(line);
      counter++;
    }

    if (counter <= 4 && !invalid) {
      cout << "Inventory is invalid, record has missing items" << endl;
      invalid = true;
    }
    if (invalid) {
      break;
    }
  }

  cout << endl
       << string(8, '#') << ' ' << fileName << " has " << (invalid ? "in" : "")
       << "valid content " << string(8, '#') << endl;

  file.close();
  return 0;
}

void test() {
  string tokenizeData = "  hello\t\tworld\n!";
  assert(tokenize(tokenizeData) == "hello");
  assert(tokenizeData == "\t\tworld\n!");
  assert(tokenize(tokenizeData) == "world");
  assert(tokenizeData == "\n!");
  assert(tokenize(tokenizeData) == "!");
  assert(tokenizeData == "");

  assert(!isValidPrice("-0.90"));
  assert(!isValidPrice("0.907"));
  assert(isValidPrice("0.90"));
  assert(!isValidPrice("12..5"));
  assert(!isValidPrice("a<.12"));
}


// checks that:
// price does not exceed 3 decimal places
// does not include extraneous decimal places
// does not include any punctuation symbols other than '.'
bool isValidPrice(string price) {
  if (price.length() - 1 - price.find('.') > 2) {
    return false;
  }
  if (count(price.begin(), price.end(), '.') != 1) {
    return false;
  }
  if (any_of(price.begin(), price.end(),
             [](char c) { return ispunct(c) && c != '.'; })) {
    return false;
  }
  return true;
}

// tokenizes str
// pseudocode: 
// fn tok(str):
//   truncate(whitespce, str)
//   tok = before(next_whitespace, str)
//   if next_whitespace > len(str):
//     str = ""
//   else:
//     str = after(next_whitespace, str)
//
string tokenize(string &str) {
  string pat = " \t\n\r";

  str.erase(0, str.find_first_not_of(pat));
  string tok = str.substr(0, str.find_first_of(pat));

  if (str.find_first_of(pat) < str.length()) {
    str = str.substr(str.find_first_of(pat), str.length());
  } else {
    str = "";
  }

  return tok;
}

// runs a check over the string iterator to make sure no other punctuation symbols except for _ are allowed :)
bool any_punct(string &str) {
  return any_of(str.begin(), str.end(),
                [](char x) { return ispunct(x) && x != '_'; });
}
