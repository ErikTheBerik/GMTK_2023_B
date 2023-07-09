extends CharacterBody2D

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var body = $Body
@onready var legs = $Legs
@onready var chest = $Chest
@onready var eyes = $Eyes
@onready var hair = $Hair

var pos
var body_color
var eyes_color
var hair_color
var hairstyle
var chestplate
var trousers

func _on_Body_frame_changed():
	sync_frames(body.frame, body.flip_h)

func sync_frames(frame, flip_h):
	legs.frame = frame
	chest.frame = frame
	eyes.frame = frame
	hair.frame = frame
	
	legs.flip_h = flip_h
	chest.flip_h = flip_h
	eyes.flip_h = flip_h
	hair.flip_h = flip_h

func _physics_process(delta):
	print(velocity)
	move_and_slide()

func initialize(_pos, _body_color, _eyes_color, _hair_color, _hairstyle, _chestplate, _trousers):
	pos = _pos
	body_color = _body_color
	eyes_color = _eyes_color
	hair_color = _hair_color
	hairstyle = _hairstyle
	chestplate = _chestplate
	trousers = _trousers

func _ready():
	position = pos
	body.self_modulate = body_color
	eyes.self_modulate = eyes_color
	hair.self_modulate = hair_color
	hair.texture = hairstyle
	chest.texture = chestplate
	legs.texture = trousers
	anim.play("idling")
	anim.seek(randf_range(0.0, anim.current_animation_length), true)
	anim.speed_scale = randf_range(0.7, 1.1)
