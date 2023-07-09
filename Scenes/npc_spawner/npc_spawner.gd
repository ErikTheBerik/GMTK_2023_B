extends Node2D

var npc = preload("res://Scenes/character/character.tscn")

#Character presets

#Skin preset
@export var body_colors : PackedColorArray = [Color("#ffb67a"), Color("#a3754e")]
#Eyes preset
@export var eye_colors : PackedColorArray = [Color("#00d5ff")]
#Hair preset
@export var hair_colors: PackedColorArray = [Color("#3c3c3c"), Color("#d8c490"), Color("#94dcc4")]
@export var hairstyles = [preload("res://Assets/character/hair.png"), preload("res://Assets/character/hair2.png")] # (Array, Texture2D)
#Chest preset
@export var chestplates = [preload("res://Assets/character/chest.png"), preload("res://Assets/character/chest2.png")] # (Array, Texture2D)
#Legs preset
@export var trousers = [preload("res://Assets/character/legs.png"), preload("res://Assets/character/legs2.png")] # (Array, Texture2D)
	
func spawn() -> CharacterBody2D:
	var instance = npc.instantiate()
	var pos = Vector2(position.x + randf_range(-50, 50), position.y)
	instance.initialize(pos, rnd_item(body_colors), rnd_item(eye_colors), rnd_item(hair_colors), rnd_item(hairstyles), rnd_item(chestplates), rnd_item(trousers))
	get_tree().current_scene.add_child(instance)
	return instance;

func rnd_item(array : Array):
	randomize()
	array.shuffle()
	return array.front()
