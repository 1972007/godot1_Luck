extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var map_limits
var map_size
var bar
var player_pos
var player_cam

var giant1stat =true
var giant2stat=true
var giant3stat=true

var health = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	map_limits = $TileMap.get_used_rect()
	map_size = $TileMap.cell_size
	bar = $CanvasProgress/Progress/TextureProgress
	player_pos = $JosephKnight/KinematicBody2D.get_pos()
	player_cam = $JosephKnight/KinematicBody2D/Camera2D
	print(bar.rect_size.x + bar.rect_position.x)
	
	
func _physics_process(delta):
	player_pos = ($JosephKnight/KinematicBody2D.get_pos())
	bar.value =((player_pos.x/7900)*100)
	$CanvasProgress/Progress/IndicatorSprite.position.x= (bar.value/100) * (bar.rect_size.x-20)
	player_cam.limit_right = map_limits.end.x * map_size.x
	#if(Input.is_action_just_pressed("debug")):
	#	$CanvasProgress/Heart._reduce_one()
	#	$JosephKnight/KinematicBody2D.health-=1
	if($JosephKnight/KinematicBody2D.health==0):
		get_tree().change_scene("res://Scene/Menu.tscn")
	if($SilviaGiant.death()=="died" and giant1stat==true):
		giant1stat =false
		$CanvasProgress/Heart._max_health()
		$JosephKnight/KinematicBody2D.health=3
	if($LuckyGiant.death()=="died" and giant2stat==true):
		giant2stat=false
		$CanvasProgress/Heart._max_health()
		$JosephKnight/KinematicBody2D.health=3
	if($JosephGiant.death()=="died"  and giant3stat==true):
		giant3stat=false
		$CanvasProgress/Heart._max_health()
		$JosephKnight/KinematicBody2D.health=3
	if(giant1stat==false and giant2stat==false and giant1stat==false and bar.value>=100):
		get_tree().change_scene("res://Scene/win.tscn")
		print("YOU WIN")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_strike(monster_node):
	pass

func monster_strike():
	$JosephKnight/KinematicBody2D.reduce_health()
	$CanvasProgress/Heart._reduce_health()
