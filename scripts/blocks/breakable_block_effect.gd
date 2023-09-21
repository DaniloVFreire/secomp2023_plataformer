extends RigidBody2D

@export var top_half_scene :Texture2D
@export var bottom_half_scene :Texture2D

var selected_half : String 
var vector : Vector2

func _ready():
	$Sprite2D.texture = 

func _physics_process(delta):
	pass
