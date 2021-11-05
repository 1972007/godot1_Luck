extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var speed=200
var movement=Vector2(0,0)
var walk_distance=0
const gravity = 20
var right=true
var health=4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	if (not $KinematicBody2D.is_on_floor()):
		movement.y += gravity
		
	else:
		movement.y = 0
	if(right):
		walk_distance+=speed
		move_right()
	if(not right):
		walk_distance-=speed
		move_left()
	if(walk_distance>24000):
		right=false
	if(walk_distance<0):
		right=true
	movement.x = lerp(movement.x,0,0.1)
	$KinematicBody2D.move_and_slide(movement,Vector2(0,-0.5))
	
	
func flip_hitbox():
	if($KinematicBody2D/attackCollision.position.x>0 and not right) or ( $KinematicBody2D/attackCollision.position.x<0 and right):
		$KinematicBody2D/attackCollision.position.x *=-1
	elif($KinematicBody2D/CollisionShape2D.position.x>0 and right) or ( $KinematicBody2D/CollisionShape2D.position.x<0  and not right):
		$KinematicBody2D/CollisionShape2D.position.x *=-1

func move_right():
	flip_hitbox()
	movement.x =speed
	$KinematicBody2D/AnimatedSprite.set_flip_h(false)
	
func move_left():
	$KinematicBody2D/AnimatedSprite.set_flip_h(true)
	flip_hitbox()
	movement.x =-speed
func reduce_health(dmg=1):
	if(health>0):
		health-=dmg
	else:
		health=0
		death()
func death():
	$KinematicBody2D.visible=false
	$KinematicBody2D/CollisionShape2D.disabled=true
	$KinematicBody2D/attackCollision.disabled=true

