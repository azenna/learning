import numpy
import random
import copy

#generates a numpy array according to the rules of 2048
def genBoard():
    board = numpy.zeros((4,4))
    num1, num2, num3, num4 = [random.randint(0,3) for i in range(4)]
    
    val1, val2 = 2, 2
    
    if random.random() < .1: val1 = 4
    if random.random() < .1: val2 = 4

    board[num1][num2], board[num3][num4] = val1, val2
    return board

#0-up 1-left 2-down 3-right
#transforms the board for piece movement
def getSections(board, direction):

  if(direction==0):
    return board

  elif(direction==1):
    return board.transpose()

  elif(direction==2):
    return numpy.flipud(board)

  elif(direction==3):
    return numpy.flipud(board.transpose())

  else: return None

#reverts the board after piece movement
def revertBoard(board, direction):
  if(direction==0):
    return board
  
  elif(direction == 1):
    return board.transpose()
  
  elif(direction == 2):
    return numpy.flipud(board)
  
  elif(direction == 3):
    return numpy.flipud(board).transpose()

#gets empty pieces on the board
def getEmpty(board):

  empty = []

  for i in range(len(board)):
    for j in range(len(board[0])):
      
      #if current position is empty add it to the empty list
      if board[i][j] == 0:
        empty.append((i, j))

  return empty

#tests wether the game is ended false if its not true if it is
def isGameEnd(board):
  empty = getEmpty(board)

  #if the board is not empty the game isn't over
  if empty:
    return False
  
  #all possible adjacent positions
  adjacent = [(0,1),(1,0),(0,-1),(-1,0)]


  #loop through the board
  for i in range(len(board)-1):
    for j in range(len(board[0])-1):
      for ad in adjacent:

        #if an adjacent piece is the same as the current one the game isn't over
        #took me forever but it turns out negative indexing was causing my problems all along I'm so tired
        if board[i+ad[0]][j+ad[1]] == board[i][j] and i+ad[0] >= 0 and j+ad[1] >= 0:
          return False
  
  #at the end return true
  return True
        

#most important function moves pieces
def getMove(board, direction):

  #get the board that we will be able to move according to the direction
  sections = getSections(board, direction)

  #create a reference to compare in case of no change
  oldSections = copy.deepcopy(sections)

  #starting slice of array
  # prev = sections[0]
  switchC = -1
  

  #while pieces are still being moved
  while(switchC != 0):
    prev = sections[0]
    switchC = 0

    for j in range(1, len(sections)):
      cur = sections[j]

      for i in range(len(cur)):
        
        #if the current is equal to the one above it multiply the previous by two and set the current to zero
        if cur[i] == prev[i] and prev[i] != 0:
          prev[i] = prev[i]*2
          cur[i] = 0
          switchC += 1
        
        #if the previous is zero move the current one up
        elif prev[i] == 0 and cur[i] != 0:
          prev[i] = cur[i]
          cur[i] = 0
          switchC += 1

      #go to next layer        
      prev = cur
  
  #revert the board to correct direction after movement
  sections = revertBoard(sections, direction)
  
  empty = getEmpty(sections)

  #control if empty is truthy
  if empty:
    newPlace = random.choice(empty)
  
  else:
    return sections
  
  #if a change has occured place a new piece. 
  if (not numpy.array_equal(sections, oldSections)):
    sections[newPlace[0]][newPlace[1]] = 4 if random.random() < .1 else 2

  return sections


#simple solve algorithim that moves pieces systematically
def simpleBoardSolve(board):
  while True:
    print(getMove(board,0))
    print(getMove(board,1))
    print(getMove(board,3))
    if isGameEnd(board):
      print("Game Over")
      return

#finds which move will create the largest value on the board or randomly shuffles
def betterSolve(board, recurCounter=0):
  print(board)

  if isGameEnd(board):
    print(recurCounter)
    print("game over")
    return board
  
  if recurCounter == 999:
    return board

  moves = [0,1,2,3]
  biggestArr = numpy.zeros((4,4))

  for move in moves:
    if numpy.amax(getMove(copy.deepcopy(board), move)) >= numpy.amax(biggestArr):
      biggestArr = getMove(board, move)
  
  return betterSolve(biggestArr, recurCounter+1)

def bestSolve(board, curMax=0):
  print(board)

  if curMax == 2048:
    return board

  print(board)

  moves = [0,1,2,3]

  for move in moves:
    newBoard = getMove(copy.deepcopy(board), move)

    if numpy.array_equal(newBoard, board):
      continue

    return bestSolve(newBoard, numpy.amax(newBoard))

    





#generate board
board = genBoard()

bestSolve(board)

