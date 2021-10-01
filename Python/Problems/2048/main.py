import numpy
import random

board = numpy.zeros((4,4))

def genBoard(board):
    num1, num2, num3, num4 = [random.randint(0,3) for i in range(4)]
    
    val1, val2 = (2, 2)
    
    if random.random() < .5: val1 = 4
    if random.random() < .5: val2 = 4

    board[num1][num2], board[num3][num4] = val1, val2
    



genBoard(board)
print(board)
