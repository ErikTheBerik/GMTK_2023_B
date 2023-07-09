extends AnimationPlayer

@onready var character: CharacterBody2D = get_parent()
var last_velocity: Vector2

func _ready():
	last_velocity = character.velocity
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var was_moving = last_velocity.length() > 1.0
	var is_moving = character.velocity.length() > 1.0
	
	if (was_moving != is_moving):
		if (is_moving):
			play("walking")
		else:
			play("idling")
	
	if (is_moving && abs(character.scale.x) >= 1.0):
		character.body.flip_h = character.velocity.x <= -1.0
		
	last_velocity = character.velocity
