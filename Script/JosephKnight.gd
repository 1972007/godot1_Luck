extends KinematicBody2D


# Declare member variables here. Examples:
export var count = 0
export var speed = 200
var movement=Vector2(0,0)
const gravity = 20
const jump_force = -400
var jump_count = 0

var cooldown=0
var attack_time=0
var health=3
# Called when the node enters the scene tree for the first time.
func _ready():
	
	$AnimatedSprite.animation="walk"
	
		
		
func _physics_process(delta):
	
	if (not is_on_floor()):
		movement.y += gravity
	else:
		movement.y = 0
		jump_count = 0
		movement.x = lerp(movement.x,0,0.1)
	if(Input.is_action_pressed("Kanan")):
		$AnimatedSprite.set_flip_h(false)
		flip_hitbox()
		movement.x = speed
	elif(Input.is_action_pressed("Kiri")):
		$AnimatedSprite.set_flip_h(true)
		flip_hitbox()
		
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
	if(is_on_ceiling()):
		movement.y = 0
	if(is_on_wall()):
		movement.x = 0
		
	if(Input.is_action_just_pressed("Attack") and cooldown<=0):
		attack()
		attack_time=0.2
		cooldown=0.2
	if(attack_time>0):
		$AnimatedSprite.animation="atk"
		$AnimatedSprite.set_frame(1)
		attack_time-=delta	
	else:
		walk()
	#print(cooldown)
	if(cooldown>0):
		cooldown-=delta
	move_and_slide(movement,Vector2(0,-1))
#	flip_hitbox()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func get_pos():
	return position

func attack():
	
	print("Attack")
#	$attackCollision.disabled=false
	var target=$RayCast2D.get_collider()
	if(target!=null):
		print(target.get_parent().health)
		if(target.get_parent().name.find("SilviaGiant"))>=0:
			target.get_parent().reduce_health()
		
	
	$AnimatedSprite.animation="atk"
	$AnimatedSprite.set_frame(1)
func walk():
	
	$AnimatedSprite.animation="walk"
#	$attackCollision.disabled=true
	
func flip_hitbox():
	if($RayCast2D.position.x<0 and Input.is_action_just_pressed("Kanan")) or ( Input.is_action_just_pressed("Kiri") and $RayCast2D.position.x>0):
		$RayCast2D.position.x *=-1
		$RayCast2D.rotation*=-1
		
	if($CollisionShape2D.position.x>0 and Input.is_action_just_pressed("Kanan")) or ( Input.is_action_just_pressed("Kiri") and $CollisionShape2D.position.x<0):
		$CollisionShape2D.position.x *=-1
	

func reduce_health(dmg=1):
	if(health>dmg):
		health-=dmg
		if($AnimatedSprite.flip_h):
			movement.x = -speed
		else:
			movement.x=speed
	else:
		health=0

func death():
	visible=false
	$CollisionShape2D.disabled=true
	$RayCast2D.enabled=false
