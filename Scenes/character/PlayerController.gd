extends Node2D

@onready var player: CharacterBody2D = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Vector2(Input.get_axis("walk_left", "walk_right"), Input.get_axis("walk_up", "walk_down"))
	dir = dir.normalized()
	player.velocity = dir * player.speed
	
