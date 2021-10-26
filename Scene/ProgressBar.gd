extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var valueBar 

# Called when the node enters the scene tree for the first time.
func _ready():
	valueBar =  $TextureProgress.value
	
func _physics_process(delta):
	if(valueBar>95):
		$AnimatedSprite.stop()
	else:
		$AnimatedSprite.position.x = valueBar
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(valueBar<0):
		valueBar=0
