extends Node2D
@onready var current_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
@onready var character: CharacterBody2D = get_parent();

@export var MIN_WAIT = 2.0
@export var MAX_WAIT = 5.0
@export var MIN_WALK = 1.0
@export var MAX_WALK = 6.0

@onready var is_walking: bool = randi() % 2

@onready var timer = Timer.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(timer)
	timer.connect("timeout", Callable(self, "ChangeState"))
	timer.start(GetTime())

func ChangeState():
	is_walking = !is_walking
	timer.start(GetTime())
	
func GetTime() -> float:
	if is_walking:
		return randf_range(MIN_WALK, MAX_WALK)
	
	return randf_range(MIN_WAIT, MAX_WAIT)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if (!is_walking):
		character.velocity = Vector2.ZERO
		return;
		
	var newDirection = Vector2.ZERO
	for child in get_children():
		if (child.has_method("GetDirection")):
			newDirection += child.GetDirection();
	
	newDirection.normalized();
	var desired_velocity = newDirection * character.speed;
	character.velocity = character.velocity.slerp(desired_velocity, 0.1).normalized() * character.speed
	current_direction = character.velocity.normalized()
