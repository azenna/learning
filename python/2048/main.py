from game import*
import numpy

numpy.set_printoptions(suppress=True)

if __name__ == '__main__':
  playerSolve(genBoard())

  for board in numpy.flipud(boardStates):
    print(board)
