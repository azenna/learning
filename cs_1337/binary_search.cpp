#include <iostream>
#include <tuple>

using namespace std;

//prototype
tuple<int, int> binarySearch(int list[], int key, int low, int high, int iterations){

    if(low > high)
        return make_tuple(-1, iterations);

    iterations += 1;

    int middle = low + (high - low) / 2;

    if(list[middle] == key)
        return make_tuple(middle, iterations);
    else if(list[middle] < key)
        return binarySearch(list, key, middle + 1, high, iterations);
    else 
        return binarySearch(list, key, low, middle - 1, iterations);
}

// function main begins program execution
int main()
{
    int list[] = { 2, 4, 7, 10, 11, 28, 34, 45, 50, 59, 60, 66, 69, 70, 75, 89, 95 };

    int key, first = 0, last = 16;
    cout <<"Enter the element to search: ";
    cin >> key;

    tuple<int, int> result = binarySearch(list, key, first, last, 0);
    int index = get<0>(result), iterations =  get<1>(result);

    if(index != -1){
        cout << "It takes " << iterations << " iterations to find the key " << key << endl;;
        cout << key << " is at index " << index << endl;
    } else {
        cout << "After " << iterations << " iterations " <<  key  << " is not found!" << endl;
    }
}
