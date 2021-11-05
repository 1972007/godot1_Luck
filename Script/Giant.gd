extends Node2D

export var count = 0
export var speed = 200
var movement=Vector2(0,0)
const gravity = 20
const jump_force = -400
var jump_count = 0

var cooldown=0
var attack_time=0
var health=5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var limit_x=1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	if (not $KinematicBody2D.is_on_floor()):
		movement.y += gravity
	else:
		movement.y = 0
		jump_count = 0
	
	movement.x = lerp(movement.x,0,0.1)
	$KinematicBody2D.move_and_slide(movement,Vector2(0,-0.5))
func reduce_health(dmg=1):
	if(health>dmg):
		health-=dmg
	else:
		health=0
func attack():
	movement.x-= (speed*2)
	limit_x -= (speed*2)
	
