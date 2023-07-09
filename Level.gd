extends Node2D
@export var CharacterAmmount: int = 100
@export var MIN_SIZE = 200.0
@export var MAX_SIZE = 800.0

var size: Vector2
var wall = preload("res://wall.tscn")

var player: CharacterBody2D = null

func _ready():	
	var viewportX : float = ProjectSettings.get_setting("display/window/size/viewport_width");
	var viewportY : float = ProjectSettings.get_setting("display/window/size/viewport_height");
	const padding = 20.0;
	size = Vector2(randf_range(MIN_SIZE, MAX_SIZE), 0.0);
	size.y = size.x * (viewportY/viewportX);
	size = size - Vector2(padding, padding)
	SetWalls()
	$Camera2D.zoom = Vector2(viewportX/size.x, viewportY/size.y);
	$Camera2D.global_position = Vector2(size.x/2.0, size.y/2.0)
	
	SpawnCharacters()
	SpawnPlayer()

func GetRandomPosition() -> Vector2:
	return Vector2(randf_range(0.0, size.x), randf_range(0.0, size.y))

func SpawnPlayer():
	player = $Spawner.spawn_player();
	var pos = GetRandomPosition()
	player.global_position = pos
	
	var size: Vector2 = player.GetImageSize();
	var player_image: Node2D = player.GetImage();
	const image_scale = 3.0;
	player_image.scale = Vector2(image_scale, image_scale)
	var image_pos = Vector2(20.0, 10.0)
	player_image.position = image_pos
	$PlayerInfo/Vertical/Image.add_child(player_image)
		
func SpawnCharacters():
	for i in CharacterAmmount:
		var newChar = $Spawner.spawn_npc();
		var pos = GetRandomPosition()
		newChar.global_position = pos

func SetWalls():
	const width = 20.0;
	const margin_error = 1.5;
	var wallTop = wall.instantiate();
	var wallRight = wall.instantiate();
	var wallBottom = wall.instantiate();
	var wallLeft = wall.instantiate();
	
	wallTop.global_position = Vector2(size.x/2.0, -width);
	wallRight.global_position = Vector2(size.x+width, size.y/2.0);
	wallBottom.global_position = Vector2(size.x/2.0, size.y+width);	
	wallLeft.global_position = Vector2(-width, size.y/2.0);
	
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
