extends Control


# Declare member variables here. Examples:
var hp_def=3
var hp_left=3
# var b = "text"
var Heart = preload("res://Scene/HeartSprite.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	var heart_len = Heart.get_len() *hp_def
	
	$HBoxContainer.set_custom_minimum_size(Vector2(heart_len,4))
	print($HBoxContainer.get_custom_minimum_size())
	for x in range(0,hp_def):
		print("heart added",heart_len,Heart.get_len())
		$HBoxContainer.add_child( preload("res://Scene/HeartSprite.tscn").instance())
	print(hp_left,$HBoxContainer.get_child(hp_left-1))

func _reduce_health(dmg=1):
	print("reduced")
	if(hp_left-dmg>=0):
		hp_left-=dmg
	else:
		hp_left =0

	$HBoxContainer.get_child(hp_left).get_node("AnimatedSprite").set_frame(1)
	
func _max_health():
	for x in range(hp_left,hp_def):
		$HBoxContainer.get_child(hp_left).get_node("AnimatedSprite").set_frame(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


