extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_right = get_len()
	rect_min_size.x = get_len()

func get_len():
	return $AnimatedSprite.get_sprite_frames().get_frame("blink",0).get_size().x * $AnimatedSprite.get_transform().get_scale().x
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
