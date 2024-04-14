#include <iostream>
#include <cassert>

using namespace std;

int flipCheck(int board[][3]){
    int current = board[0][0];

    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            if(current != board[i][j]){
                return 0;
            }
        }
    }

    return current;

}

int main(){

    int numbers1[3][3] = { 
		{1, 1, 1},
        {1, 1, 1},
        {1, 1, 1} 
	};

    assert(flipCheck(numbers1) == 1);

    //game ends as all cells have 2
    int numbers2[3][3] = { 
		{2, 2, 2},
        {2, 2, 2},
        {2, 2, 2} 
	};
    assert(flipCheck(numbers2) == 2);
	//game continues
    int numbers3[3][3] = {
		{1, 1, 1},
        {1, 1, 1},
        {1, 1, 2} 
	};
    assert(flipCheck(numbers3) == 0);

    //game continues
    int numbers4[3][3] = { 
		{2, 2, 2},
        {2, 2, 2},
        {2, 2, 1} 
	};
    assert(flipCheck(numbers4) == 0);

    return 0;
}
