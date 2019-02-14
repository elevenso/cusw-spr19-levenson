#Step 1: Create memory for Person
people = []
class Person():
    def __init__(self, name, grade):
        Person.name = name
        Person.grade = grade
        Person.screenLocation = PVector(width/2, height/2)
        
     #See if my mouse cursor is near my person
    def hoverEvent(self):
        xDistance = float(abs(mouseX - self.screenLocation.x))
        yDistance = float(abs(mouseY - self.screenLocation.y))
    
        if xDistance <= 15 and yDistance <= 15:
            return True
        else:
            return False
        
    def circleLocation(theta):
        radius = 0.35*height
        self.screenLocation.x = 0.8*width/2 + radius*sin(theta)
        self.screenLocation.y = height/2 + radius*cos(theta)
    
    def randomLocation(self):
        screenLocation = PVector(random(0.8*width), random(height))
        return screenLocation
    
    def draw(self):
        noStroke() #no circle outline
        
        ellipse(self.screenLocation.x, self.screenLocation.y, 30, 30)
    
        noFill()
        stroke(255)
        strokeWeight(5)
        ellipse(self.screenLocation.x, self.screenLocation.y, 30, 30)
        
        fill(255)
        text(Person.name + ' in year: ' + Person.grade, self.screenLocation.x+25, self.screenLocation.y - 25)
        
class Connection():
    def __init__(p1, p2, _type):
        self.origin = p1
        self.destination = p2
        self.type = _type
    def draw():
        x1 = float(origin.screenLocation.x)
        y1 = float(origin.screenLocation.y)
        x2 = float(destination.screenLocation.x)
        y2 = float(destination.screenLocation.y)
        
        strokeWeight(5)
        line(x1, y1, x2, y2)
        
        fill(255)
        text(type, (x1+x2)/2 + 20, (y1+y2)/2)
    
def setup():
    size(800, 700)
    lucy = Person ('Lucy', '2')
    people.append(lucy)
    emily = Person('Emily', '1')
    people.append(emily)
    # Runs over and over at 60 - FPS
    
def draw():
    background(0) #black background
    #background(255); white background

    for p in people:
        p.draw()
