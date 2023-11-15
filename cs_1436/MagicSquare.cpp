#include <iostream>
#include <cassert>
#include <set>

using namespace std;

bool magicSquare(int square[3][3]){

    set<int> nums;

    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){

            int num = square[i][j];

            if(num < 1 || num > 9){
                return false;
            }

            auto ret = nums.emplace(num);

            if(!ret.second){
                return false;
            }
        }
    }
    
    for(int i = 0; i < 3; i++){
        if((square[i][0] + square[i][1] + square[i][2]) != 15){
            return false;
        }
    }
    for(int i = 0; i < 3; i++){
        if(square[0][i] + square[1][i] + square[2][i] != 15){
            return false;
        }
    }
    if(square[0][0] + square[1][1] + square[2][2] != 15){
        return false;
    }
    if(square[0][2] + square[1][1] + square[2][0] != 15){
        return false;
    }
    return true;
}

int main(){

    int test1[3][3] = {
        {4, 9, 2},
        {3, 5, 7},
        {8, 1, 1},
    };
    int test2[3][3] = {
        {15, 0, 0},
        {0, 15, 0},
        {0, 0, 15},
    };
    int test3[3][3] = {
        {2, 7, 6},
        {9, 5, 1},
        {4, 3, 8},
    };
    int test4[3][3] = {
        {6, 1, 8},
        {7, 5, 3},
        {2, 9, 4},
    };

    assert(!magicSquare(test1));
    assert(!magicSquare(test2));
    assert(magicSquare(test3));
    assert(magicSquare(test4));

    return 0;   
}
