#include <iostream>

using namespace std;

int findId(int, int [], int);
void insertId(int, int [], int);

int main()
{
    const int MAX_SIZE = 100;

    int sid[MAX_SIZE] = { 1, 3, 6, 8, 10};
    int index, id;
 

    // To insert more numbers
      int num, size = 5;
      cin >> num;
            
      for(int i = 0; i < num; i++){
         cin >> id;
         int pos = findId(id, sid, size);
         if(pos == -1){
            cout << id << " not found" << endl;
            insertId(id, sid, size);
            size += 1;
            cout << id << " inserted into the array" << endl;
         }
         else {
            cout << id << " found at position " << pos << endl;
         }
      }

     /*
     Enter your code
     */
   cout << "The array with all the elements inserted are: ";
   for(int i = 0; i < size; i++){
      cout << sid[i] << ' ';
   }
   cout << endl;
   
   return 0;
}

// should return the index of val if it is present in the array
// otherwise return -1
int findId(int val, int arrId[], int sz)
{
   /*
     Enter your code
     */
   for(int i = 0; i < sz; i++){
      if(arrId[i] == val){
         return i;
      }
   }
   
   return -1;
}

void insertId(int val, int arrId[], int sz)
{
   int temp = -1, index = -1;
   for(int i = 0; i < sz; i ++){
      if(arrId[i] > val){
         temp = arrId[i];
         arrId[i] = val;
         index = i + 1;
         break;
      }
   }
   if(temp == -1){
      arrId[sz] = val;
   } else {
      for(int i = index; i < sz; i++){
         int temp2 = arrId[i];
         arrId[i] = temp;
         temp = temp2;
      }
      arrId[sz] = temp;
   }
}

