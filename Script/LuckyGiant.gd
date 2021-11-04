extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed=200
const gravity = 10
var jump_count = 0
var rng = RandomNumberGenerator.new()
var movement=Vector2(0,0)
const jump_force = -700
var right_left=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	if (not $KinematicBody2D.is_on_floor()):
		movement.y += gravity
		$KinematicBody2D/attackCollision.disabled=false
		
	else:
		movement.y = 0
		if(jump_count<=0):
			if(right_left==0):
				move_right()
				right_left=1
			else:
				move_left()
				right_left=0
		jump_count = 0
	movement.x = lerp(movement.x,0,0.1)
	$KinematicBody2D.move_and_slide(movement,Vector2(0,-0.5))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move_right():
	movement.y += jump_force
	jump_count=1
	movement.x +=speed
	
func move_left():
	movement.y += jump_force
	jump_count=1
	movement.x -=speed
