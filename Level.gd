extends Node2D
@export var CharacterAmmount: int = 100

var size: Vector2
var wall = preload("res://wall.tscn")

func _ready():	
	var viewportX : float = ProjectSettings.get_setting("display/window/size/viewport_width");
	var viewportY : float = ProjectSettings.get_setting("display/window/size/viewport_height");
	const padding = 20.0;
	size = Vector2(randf_range(500.0, 720.0), 0.0);
	size.y = size.x * (viewportY/viewportX);
	size = size - Vector2(padding, padding)
	SetWalls()
	$Camera2D.zoom = Vector2(viewportX/size.x, viewportY/size.y);
	$Camera2D.global_position = Vector2(size.x/2.0, size.y/2.0)
	for i in CharacterAmmount:
		var newChar = $Spawner.spawn();
		var pos = Vector2(randf_range(0.0, size.x), randf_range(0.0, size.y))
		newChar.global_position = pos
#		get_tree().current_scene.add_child(newChar)


func SetWalls():
	const width = 20.0;
	const margin_error = 1.5;
	var wallTop = wall.instantiate();
	var wallRight = wall.instantiate();
	var wallBottom = wall.instantiate();
	var wallLeft = wall.instantiate();
	
	wallTop.global_position = Vector2(size.x/2.0, 0.0);
	wallRight.global_position = Vector2(size.x, size.y/2.0);
	wallBottom.global_position = Vector2(size.x/2.0, size.y);	
	wallLeft.global_position = Vector2(0.0, size.y/2.0);
	
	wallTop.rotate(deg_to_rad(90.0))
	wallBottom.rotate(deg_to_rad(90.0))
	
	wallTop.get_node("Shape").shape.size = Vector2(size.x, width) * margin_error
	wallRight.get_node("Shape").shape.size = Vector2(width, size.y) * margin_error
	wallBottom.get_node("Shape").shape.size = Vector2(size.x, width) * margin_error
	wallLeft.get_node("Shape").shape.size = Vector2(width, size.y) * margin_error
	
	add_child(wallTop)
	add_child(wallRight)
	add_child(wallBottom)
	add_child(wallLeft)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
