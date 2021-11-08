extends Node2D

export var count = 0
export var speed = 200
var movement=Vector2(0,0)
const gravity = 20
const jump_force = -400
var jump_count = 0

var walk_distance=0
var right=false
var cooldown=3
var attack_time=0
var health=5
var cooling=false
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
	
	if(right and cooldown>=3):
		cooling=false
		walk_distance-=speed
		$KinematicBody2D/Area2D/CollisionShape2D.disabled=false
		move_right()
	if(not right and cooldown>=3):
		cooling=false
		walk_distance+=speed
		$KinematicBody2D/Area2D/CollisionShape2D.disabled=false
		move_left()
	cooldown+=delta
	#print("Cooldown : ",cooldown)
	if(walk_distance>=40000 and cooling==false):
		cooldown=0
		$KinematicBody2D/Area2D/CollisionShape2D.disabled=true
		$KinematicBody2D/AnimatedSprite.animation="idle"
		right=true
		cooling=true
	if(walk_distance<=0 and cooling==false):
		$KinematicBody2D/Area2D/CollisionShape2D.disabled=true
		$KinematicBody2D/AnimatedSprite.animation="idle"
		cooldown=0
		right=false
		cooling=true
	movement.x = lerp(movement.x,0,0.1)
	$KinematicBody2D.move_and_slide(movement,Vector2(0,-0.5))
func reduce_health(dmg=1):
	if(health>dmg):
		health-=dmg
	else:
		health=0
	

func flip_hitbox():
	if($KinematicBody2D/CollisionShape2D.position.x>0 and  not right) or ($KinematicBody2D/CollisionShape2D.position.x<0  and right):
		$KinematicBody2D/CollisionShape2D.position.x *=-1
	if($KinematicBody2D/Area2D/CollisionShape2D.position.x>0 and not right) or ($KinematicBody2D/Area2D/CollisionShape2D.position.x<0  and right):
		$KinematicBody2D/Area2D/CollisionShape2D.position.x *=-1
	

func move_right():
	flip_hitbox()
	movement.x =speed
	$KinematicBody2D/AnimatedSprite.set_flip_h(true)
	$KinematicBody2D/AnimatedSprite.animation="walk"
	
func move_left():
	movement.x =-speed
	$KinematicBody2D/AnimatedSprite.set_flip_h(false)
	$KinematicBody2D/AnimatedSprite.animation="walk"
	flip_hitbox()

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
