#include <iostream>
#include <cassert>

using namespace std;

int checkBoard(int board[3][3]){
    
    // check horizontal wins
    for(int i = 0; i < 3; i++){
        int* row = board[i];
        if(row[0] == row[1] && row[1] == row[2]){
            return row[0];
        }
    }

    // check vertical wins
    for(int i = 0; i < 3; i++){
        if(board[0][i] == board[1][i] && board[1][i] == board[2][i]){
            return board[0][i];
        }
    }

    // check diagonal wins
    if(board[0][0] == board[1][1] && board[1][1] == board[2][2]){
        return board[0][0];
    }

    if(board[0][2] == board[1][1] && board[1][1] == board[2][0]){
        return board[0][2];
    }
    
    // check for unfilled spaces
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            if(board[i][j] == 0){
                return 0;
            }
        }
    }

    // return a draaw if none of above conditions met
    return -1;
}

int fromChar(char x){
    switch(x){
        case 'X':
            return 1;
        case 'O':
            return 2;
        default:
            return -1;
    }
}

char toChar(int x){
    switch(x){
        case 1:
            return 'X';
        case 2:
            return 'O';
        default:
            return '*';
    }
}

void printBoard(int board[3][3]){
    for(int i = 0; i < 3; i++){
        for(int j = 0; j < 3; j++){
            cout << toChar(board[i][j]) << ' ';
        }
        cout << endl;
    }
}

int main(){
    int board1[3][3] = {
        {1, 2, 1},
        {2, 1, 2},
        {0, 1, 2},
    };
    int board2[3][3] = {
        {1, 2, 1},
        {2, 1, 2},
        {1, 1, 2},
    };
    int board3[3][3] = {
        {1, 2, 1},
        {2, 2, 2},
        {1, 1, 0},
    };
    int board4[3][3] = {
        {1, 2, 1},
        {2, 2, 1},
        {1, 1, 2},
    };
    int board5[3][3] = {
        {1, 0, 2},
        {0, 1, 0},
        {0, 0, 2},
    };

    assert(checkBoard(board1) == 0);
    assert(checkBoard(board2) == 1);
    assert(checkBoard(board3) == 2);
    assert(checkBoard(board4) == -1);
    assert(checkBoard(board5) == 0);

    int gameBoard[3][3] = {
        {0, 0, 0},
        {0, 0, 0},
        {0, 0, 0},
    };
    
    int turn = 1;

    while(checkBoard(gameBoard) == 0){
        printBoard(gameBoard);

        cout << "It is Player" << turn << "'s turn." << endl;

        int row, column;

        do {
            cout << "Please enter your move in the form of, <ROW> <COLUMN>: ";
            cin >> row >> column;
        } while (row < 0 || row > 2 || column < 0 || column > 2);

        gameBoard[row][column] = turn;

        if(turn == 1){
            turn = 2;
        } else {
            turn = 1;
        }
    }

    printBoard(gameBoard);
    int end = checkBoard(gameBoard);

    if(end == -1){
        cout << "Tie! Neither player won" << endl;
    } else {
        cout << "Player" << end << " wins! Congratulations!" << endl;
    }

    return 0;
}

