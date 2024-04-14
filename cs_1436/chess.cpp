#include <iostream>

using namespace std;

const int board[8][8] = {{0}};

bool capturePawn(int row, int col){
    for(int i = 0; i < 8; i++){
        if(board[i][col] == 1 || board[row][i] == 1){
            return true;
        }
    }
    return false;
}

int main(){
    return 0;
}
