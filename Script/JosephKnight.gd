extends KinematicBody2D


# Declare member variables here. Examples:
export var count = 0
export var speed = 200
var movement=Vector2(0,0)
const gravity = 20
const jump_force = -400
var jump_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if (not is_on_floor()):
		movement.y += gravity
	else:
		movement.y = 0
		jump_count = 0
		movement.x = lerp(movement.x,0,0.1)
	if(Input.is_action_pressed("Kanan")):
		$AnimatedSprite.set_flip_h(false)
		movement.x = speed
	elif(Input.is_action_pressed("Kiri")):
		$AnimatedSprite.set_flip_h(true)
		movement.x = -speed
	else:
		movement.x = 0
	if(Input.is_action_just_pressed("Lompat") and (is_on_floor() or jump_count<2)):
		$AnimatedSprite.set_frame(3)
		movement.y = jump_force
		jump_count +=1
	if movement.x == 0 and movement.y == 0:
		$AnimatedSprite.set_frame(0)
		$AnimatedSprite.stop()
	elif(movement.x!=0):
		$AnimatedSprite.play()
	move_and_slide(movement,Vector2(0,-1))
	if(is_on_ceiling()):
		movement.y = 0
	if(is_on_wall()):
		movement.x = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_pos():
	return position
