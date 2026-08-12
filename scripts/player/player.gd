extends CharacterBody2D

const SPEED := 80.0
const FRAME_SIZE := 64
const ANIM_FPS := 8.0

var _facing := "down"

func _ready() -> void:
	_setup_animations()
	$AnimatedSprite2D.play("idle_down")


func _setup_animations() -> void:
	var sf := SpriteFrames.new()
	var base := "res://assets/sprites/characters/body_a/Animations/"

	# 注意：素材包命名不统一，Idle/Run 的 "up" 是小写，Walk 的 "Up" 是大写
	var anim_defs := {
		"idle_down": { "path": base + "Idle_Base/Idle_Down-Sheet.png", "frames": 4 },
		"idle_up": { "path": base + "Idle_Base/Idle_up-Sheet.png", "frames": 4 },
		"idle_side": { "path": base + "Idle_Base/Idle_Side-Sheet.png", "frames": 4 },
		"walk_down": { "path": base + "Walk_Base/Walk_Down-Sheet.png", "frames": 6 },
		"walk_up": { "path": base + "Walk_Base/Walk_Up-Sheet.png", "frames": 6 },
		"walk_side": { "path": base + "Walk_Base/Walk_Side-Sheet.png", "frames": 6 },
	}

	for anim_name in anim_defs:
		var def: Dictionary = anim_defs[anim_name]
		var texture := load(def.path) as Texture2D
		sf.add_animation(anim_name)
		sf.set_animation_loop(anim_name, true)
		sf.set_animation_speed(anim_name, ANIM_FPS)
		for i in range(def.frames):
			var atlas := AtlasTexture.new()
			atlas.atlas = texture
			atlas.region = Rect2(i * FRAME_SIZE, 0, FRAME_SIZE, FRAME_SIZE)
			sf.add_frame(anim_name, atlas)

	$AnimatedSprite2D.sprite_frames = sf


func _physics_process(_delta: float) -> void:
	var input_dir := Vector2.ZERO

	if Input.is_physical_key_pressed(KEY_A):
		input_dir.x -= 1
	if Input.is_physical_key_pressed(KEY_D):
		input_dir.x += 1
	if Input.is_physical_key_pressed(KEY_W):
		input_dir.y -= 1
	if Input.is_physical_key_pressed(KEY_S):
		input_dir.y += 1

	velocity = input_dir.normalized() * SPEED

	if input_dir != Vector2.ZERO:
		if absf(input_dir.x) >= absf(input_dir.y):
			_facing = "side"
			$AnimatedSprite2D.flip_h = input_dir.x < 0
		elif input_dir.y > 0:
			_facing = "down"
		else:
			_facing = "up"
		$AnimatedSprite2D.play("walk_" + _facing)
	else:
		$AnimatedSprite2D.play("idle_" + _facing)

	move_and_slide()
