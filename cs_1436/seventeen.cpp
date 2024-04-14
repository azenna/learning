#include <iostream>

using namespace std;

int elementFoundAt(int searchValue){
    int arr[] = {1, 3, 2, 5, 8, 4, 20, 17, 25, 80};
    int arrSize = sizeof(arr)/sizeof(int);

    for(int i = 0; i < arrSize; i++){
        if(arr[i] == searchValue){
            return i;
        }
    }

    return -1;
}

int main(){

    int ui;
    cout << "Enter searcch value (-999 to end) : ";
    cin >> ui;
    while(ui != -99){
        int index = elementFoundAt(ui);
        if(index != -1){
            cout << ui << " is at index :" << index;
        }else{
            cout << ui << " is not in array" << endl;
        }
        cout << "\nEnter search value (-99 to end) : ";
        cin >> ui;
    }
}
