extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var speed=200
var movement=Vector2(0,0)
var walk_distance=0
var right=true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	if(right):
		walk_distance+=speed
		move_right()
	else:
		walk_distance-=speed
		move_left()
	movement.x = lerp(movement.x,0,0.1)
	$KinematicBody2D.move_and_slide(movement,Vector2(0,-0.5))
func flip_hitbox():
	if($attackCollision.position.x<0 and Input.is_action_just_pressed("Kanan")) or ( Input.is_action_just_pressed("Kiri") and $attackCollision.position.x>0):
		$attackCollision.position.x *=-1
	if($CollisionShape2D.position.x>0 and Input.is_action_just_pressed("Kanan")) or ( Input.is_action_just_pressed("Kiri") and $CollisionShape2D.position.x<0):
		$CollisionShape2D.position.x *=-1

func move_right():
	flip_hitbox()
	movement.x =speed
	
func move_left():
	flip_hitbox()
	movement.x =-speed
