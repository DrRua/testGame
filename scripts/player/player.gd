extends CharacterBody2D

const SPEED := 80.0

var _facing := "down"

func _ready() -> void:
	$AnimatedSprite2D.play("idle_down")


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
	# 正左方 ±75°（120°~240°）→ side 朝左
	# 正右方 ±75°（300°~360° + 0°~60°）→ side 朝右
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
