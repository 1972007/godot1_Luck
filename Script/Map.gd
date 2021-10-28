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

func _physics_process(delta):
	player_pos = ($JosephKnight/KinematicBody2D.get_pos())
	bar.value = (player_pos.x/ 7900)*100
	print(player_pos,bar.value,map_limits.end.x," ",player_pos.x/(map_limits.end.x*map_size.x)," ",map_limits.end.x*map_size.x)
	player_cam.limit_right = map_limits.end.x * map_size.x
	
	#if($JosephKnight/KinematicBody2D.position.y>0):
		
	
#x max = 8435
#x min = -57
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
