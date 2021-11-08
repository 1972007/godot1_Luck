extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed=700
const gravity = 10
var jump_count = 0
var rng = RandomNumberGenerator.new()
var movement=Vector2(0,0)
const jump_force = -700
var right_left=0
var health=4
var cooldown=0.3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#print($KinematicBody2D/attackCollision.disabled)
	if (not $KinematicBody2D.is_on_floor()):
		movement.y += gravity
		
	else:
		movement.y = 0
		if(jump_count<=0 and cooldown>=0.3):
			attack()
			cooldown=0
		else:
			cooldown+=delta	
	movement.x = lerp(movement.x,0,0.1)
	$KinematicBody2D.move_and_slide(movement,Vector2(0,-0.5))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move_right():
	movement.y += jump_force
	movement.x =speed
	
func move_left():
	movement.y += jump_force
	movement.x =-speed

func reduce_health(dmg=1):
	if(health>dmg):
		health-=dmg
	else:
		health=0
func attack():
	if(right_left==0):
		move_right()
		right_left=1
	else:
		move_left()
		right_left=0
	

func death():
	if(health<=0):
		$KinematicBody2D.visible=false
		$KinematicBody2D/CollisionShape2D.disabled=true
		$KinematicBody2D/Area2D/CollisionShape2D.disabled=true
		return "died"
	else:
		return "lived"


func _on_Area2D_body_entered(body):
	if(body.get_parent().name=="JosephKnight"):
		body.get_parent().get_parent().monster_strike()
		attack()
		
