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

	# 朝向由鼠标位置决定（俯视角第三人称枪战控制）
	_update_facing_by_mouse()

	if input_dir != Vector2.ZERO:
		$AnimatedSprite2D.play("walk_" + _facing)
	else:
		$AnimatedSprite2D.play("idle_" + _facing)

	move_and_slide()


func _update_facing_by_mouse() -> void:
	var to_mouse := get_global_mouse_position() - global_position
	if to_mouse == Vector2.ZERO:
		return

	var angle := rad_to_deg(to_mouse.angle())
	if angle < 0:
		angle += 360.0

	# 正下方 ±30°（60°~120°）→ down
	# 正上方 ±30°（240°~300°）→ up
	# 正左方 ±75°（105°~255°，去除上下后为 120°~240°）→ side 朝左
	# 正右方 ±75°（285°~75°，去除上下后为 300°~360°+0°~60°）→ side 朝右
	if angle >= 60.0 and angle <= 120.0:
		_facing = "down"
		$AnimatedSprite2D.flip_h = false
	elif angle >= 240.0 and angle <= 300.0:
		_facing = "up"
		$AnimatedSprite2D.flip_h = false
	elif angle > 120.0 and angle < 240.0:
		_facing = "side"
		$AnimatedSprite2D.flip_h = true
	else:
		_facing = "side"
		$AnimatedSprite2D.flip_h = false
