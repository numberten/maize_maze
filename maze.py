from random import randrange as rand
import sys

class Cell:
   def __init__(self):
      self.edges   = [1,1,1,1]

   def setEdge(self, index, value):
      self.edges[index] = value

   def getEdges(self):
      return self.edges

class Grid:
   def __init__(self, width, height, art):
      self.width         = int(width)
      self.height        = int(height)
      self.art           = art
      self.visited       = [[False for i in range(self.height)] for i in range(self.width)]
      self.cells         = [[Cell() for i in range(self.height)] for i in range(self.width)]
      self.x             = rand(self.width)
      self.y             = rand(self.height)
      self.total_visited = 0
      self.generateMaze(0,0)

   def echo(self):
      echo = str(self.width)+":"+str(self.height)+":"+self.art+"\n"
      for i in range(self.width):
         for j in range(self.height):
            echo = echo + "["+str(i)+"]["+str(j)+"]"+str(self.cells[i][j].getEdges())+"\n"
      return echo

   def listAdjacent(self):
      if (not self.visited[self.x][self.y]):
         self.visited[self.x][self.y] = True
         self.total_visited += 1
      adjacent = [] 
      #(cell, index in current's edge list, index of current in this list, dx, dy)
      #north
      if (self.y > 0 and not self.visited[self.x][self.y-1]):
         adjacent.append((self.cells[self.x][self.y-1],0,1,0,-1))
      #south
      if (self.y < self.height-1 and not self.visited[self.x][self.y+1]):
         adjacent.append((self.cells[self.x][self.y+1],1,0,0,1))
      #west
      if (self.x > 0 and not self.visited[self.x-1][self.y]):
         adjacent.append((self.cells[self.x-1][self.y],2,3,-1,0))
      #east
      if (self.x < self.width-1 and not self.visited[self.x+1][self.y]):
         adjacent.append((self.cells[self.x+1][self.y],3,2,1,0))
      return adjacent

   def generateMaze(self, first_x, first_y):
      stack = []
      self.x, self.y = first_x,first_y
      current = self.cells[self.x][self.y]
      while (self.total_visited < self.width*self.height):
         adjacent = self.listAdjacent()
         if (adjacent != []):
            r = rand(len(adjacent))
            neighbor = adjacent[r]
            current.setEdge(neighbor[1], 0)
            neighbor[0].setEdge(neighbor[2], 0)
            stack.append((current,self.x,self.y))
            current = neighbor[0]
            self.x += neighbor[3]
            self.y += neighbor[4]
         elif (stack != []):
            head = stack.pop()
            current, self.x, self.y = head[0], head[1], head[2]
         else:
            self.x,self.y = rand(self.width),rand(self.height)
            current = self.cells[self.x][self.y]
      #print("All done?\nCells visited: "+str(self.total_visited))
if (len(sys.argv) == 4):
   g = Grid(sys.argv[1],sys.argv[2], sys.argv[3])
   print(g.echo())
else:
   print("Error: command line args = width height artstyle, ex:>python maze.py 30 20 1")

