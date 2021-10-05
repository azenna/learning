import numpy
import random
import copy

def genBoard():
    board = numpy.zeros((4,4))
    num1, num2, num3, num4 = [random.randint(0,3) for i in range(4)]
    
    val1, val2 = 2, 2
    
    if random.random() < .1: val1 = 4
    if random.random() < .1: val2 = 4

    board[num1][num2], board[num3][num4] = val1, val2
    return board

#0-up 1-left 2-down 3-right
def getSections(board, direction):

  if(direction==0):
    return board

  elif(direction==1):
    return board.transpose();

  elif(direction==2):
    return numpy.flipud(board)

  elif(direction==3):
    return numpy.flipud(board.transpose())

  else: return None

def revertBoard(board, direction):
  if(direction==0):
    return board
  
  elif(direction == 1):
    return board.transpose()
  
  elif(direction == 2):
    return numpy.flipud(board)
  
  elif(direction == 3):
    return numpy.flipud(board).transpose()

def getEmpty(board):
  empty = []
  for i in range(len(board)):
    for j in range(len(board[0])):
      if board[i][j] == 0:
        empty.append((i, j))
  return empty

def gameEnd(board):
  empty = getEmpty(board)

  if empty:
    return False
  
  else:
    adjacent = [(0,1),(1,0),(0,-1),(-1,0)]

    for i in range(len(board)):
      for j in range(len(board[0])):
        for ad in adjacent:

          

   


    
def getMove(board, direction):
  sections = getSections(board, direction)

  oldSections = copy.deepcopy(sections)

  prev = sections[0]
  switchC = -1
  

  while(switchC != 0):
    prev = sections[0]
    switchC = 0

    for j in range(1, len(sections)):
      cur = sections[j]

      for i in range(len(cur)):
        
        if cur[i] == prev[i] and prev[i] != 0:
          prev[i] = prev[i]*2
          cur[i] = 0
          switchC += 1
        
        elif prev[i] == 0 and cur[i] != 0:
          prev[i] = cur[i]
          cur[i] = 0
          switchC += 1
              
      prev = cur
  
  sections = revertBoard(sections, direction)
  
  empty = getEmpty(sections)

  if empty:
    newPlace = random.choice(empty)
  
  else:
    return sections
  
  if (not numpy.array_equal(sections, oldSections)):
    sections[newPlace[0]][newPlace[1]] = 4 if random.random() < .1 else 2

  return sections



def simpleBoardSolve(board):
  while True:
    cur_board = copy.deepcopy(board)
    print(getMove(board,0))
    print(getMove(board,1))
    print(getMove(board,3))
    print(cur_board)
    if numpy.array_equal(board, cur_board): break

def playerSolve(board):
  while True:  
    try:
      move = int(input("move: "))
    except: continue



board = genBoard()
print(board)

simpleBoardSolve(board)

