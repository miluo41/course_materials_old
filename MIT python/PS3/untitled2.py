import math
class Coordinate(object):
    def __init__(self,x,y):
        self.x=x
        self.y=y
    def __str__(self):
        return '<'+str(self.x)+','+str(self.y)+'>'
    def distance(self,other):
        diff_x=self.x-other.x
        diff_y=self.y-other.y
        dist=math.sqrt(diff_x**2+diff_y**2)
        return dist
        
origin=Coordinate(0,0)
a=Coordinate(3,4)
print(origin.distance(a))
print(Coordinate.distance(origin,a))
