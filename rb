import pgzrun
import random

FONT_option = (255, 255, 255)
WIDTH = 800
HEIGHT = 600
CENTRE_X = WIDTH / 2
CENTRE_Y = HEIGHT / 2
CENTRE = (CENTRE_X, CENTRE_Y)
FINAL_LEVEL = 6
START_SPEED = 10
ITEMS = ["bag","battery","bottle","chips"]

game_over = False
game_complete = False
current_level = 1
items = []
animations = []

def draw():
    global items, current_level, game_over, game_complete
    screen.clear()
    screen.blit("bground", (0, 0))
    if game_over:
        display_message("GAME OVER", "Try again.")
    elif game_complete:
        display_message("YOU WON!", "Well done.")
    else:
      for item in items:
          item.draw()

def display_message(text,sub_text):
    screen.draw.text(text,frontsize=80,centre=CENTER,color="white")
    screen.draw.text(sub_text,frontsize=40,centre=(CENTRE_X,CENTRE_Y+40),color="gray")

def get_option(extra_items):
    create_items=["bag"]
    for i in range(0,extra_items):
        random_option = random.choice(ITEMS)
        create_items.append(random_option)
    return create_items

def create_items(num_items):
    new_items=[]
    for option in num_items:
        item = Actor(option)
        new_items.append(item)
    return new_items

def layout(items):
    gaps=len(items)+1
    gap_size=WIDTH/gaps
    random.shuffle(items)
    for index,item in enumerate(items):
        new_x=(indx+1)*gap_size
        item.x=new_x

def animate(items):
    global animations
    for item in items:
        duration=START_SPEED - current_level
        item.anchor=("center","bottom")
        animation=animate(item,duration=duration,on_finished=handle_game_over,y=HEIGHT)
        animations.append(animation)

def handle_game_over():
    global game_over
    game_over = True

def on_mouse_down(pos):
    global items,current_level
    for item in items:
        if item.collidepoint(pos):
            if "paper" in items.images:
             handle_game_complete
            else:
             handle_game_over

def handle_game_complete():
    global current_level,items,animations,game_complete
    stop_animations(animations)
    if current_level == FINAL_LEVEL:
        game_complete = True
    else:
        current_level += 1
        items = []
        animations = []

def stop_animations(stop):
    for animation in stop :
        if animation.runing:
            animation.stop()

pgzrun.go()
