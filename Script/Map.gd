extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var map_limits
var map_size
var bar
var player_pos
var player_cam


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
	
#x max = 8435
#x min = -57
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_strike(monster_node):
	pass

func monster_strike(monster_node):
	pass
