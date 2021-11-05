extends Node2D

export var count = 0
export var speed = 200
var movement=Vector2(0,0)
const gravity = 20
const jump_force = -400
var jump_count = 0

var cooldown=0
var attack_time=0
var health=5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
