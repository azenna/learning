#include <iostream>
#include <vector>
using namespace std;

bool isSymmetrical(vector<vector<int>> matrix){
    for(int i = 0; i < matrix.size(); i++){
        for(int j = i; j < matrix.size(); j++){
            if(matrix[i][j] != matrix[j][i]){
                return false;
            }
        }
    }
    return true;
};

vector<vector<int>> readMatrix(){
    int mrow, mcol;
    
    cout <<  "Enter the number of rows and columns: ";
    cin >> mrow >> mcol;

    while(mrow != mcol){
        cout << "The number of rows and columns must be same." << endl;
        cin >> mrow >> mcol;
    }

    vector<vector<int>> matrix;
    int buf;

    cout << "Enter the values for the matrix: \n";

    for(int i = 0; i < mrow; i++){
        vector<int> row;
        for(int j = 0; j < mcol; j++){
            cin >> buf;
            row.push_back(buf);
        }
        matrix.push_back(row);
    }

    return matrix;
}

int main()
{
    vector<vector<int>> matrix = readMatrix();

    if(isSymmetrical(matrix)){
        cout << "The matrix is symmetrical." << endl;
    } else {
        cout << "The matrix is not symmetrical." << endl;
    }

    return 0;
}
