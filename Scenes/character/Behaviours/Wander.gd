extends Node2D
@export var length = 7.0
@export var radius = 3.0
@export var weight = 10.0

@onready var controller = get_parent();

func GetDirection():
	var startPos: Vector2 = global_position + controller.current_direction * length
	var randomPos: Vector2 = startPos + (Vector2(randf_range(-radius, radius), randf_range(-radius, radius)))
	
	return (global_position - randomPos).normalized() * weight;
