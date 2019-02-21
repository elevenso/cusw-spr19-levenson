x = 30
def setup():
    size(640, 360)
    url = "https://sap.mit.edu/sites/sap.mit.edu/files/styles/large_square_thumb/public/Jun_6_MIT_QS_ranking.jpg?itok=jEPFW29j"
    # Load image from a web server
    global webImg
    webImg = loadImage(url, "png")
    
def draw():
    background(0)
    image(webImg, x, mouseY)
def mousePressed():
    global x
    if x<640:
        x+=100
    else:
        x-=100
    redraw()
