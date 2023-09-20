extends CharacterBody2D


@export var movement_data : PlayerMovementData

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var ray_cast_2d = $RayCast2D

func _physics_process(delta):
	var input_y_axis = Input.get_axis("ui_left", "ui_right")
	aply_gravity(delta)
	handle_jump()
	apply_friction(input_y_axis,delta)
	handle_acceleration(input_y_axis, delta)
	update_animations(input_y_axis)
	
	if is_on_ceiling():
		destroy_block()
	
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	var just_left_ledge = was_on_floor and (not is_on_floor()) and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	
func aply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y += movement_data.jump_valocity
	else:
		if Input.is_action_just_released("ui_up") and velocity.y < movement_data.jump_valocity /2:
			velocity.y = movement_data.jump_valocity /2

func apply_friction(input_y_axis, delta):
	if input_y_axis == 0:
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)
	else:
		velocity.x = move_toward(velocity.x,movement_data.speed * input_y_axis, movement_data.acceleration * delta)

func handle_acceleration(input_y_axis, delta):
	if input_y_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_y_axis, movement_data.acceleration * delta)

func update_animations(input_y_axis):
	var animation_name = "idle"
	if not is_on_floor():
		animation_name = "jump"
	elif input_y_axis != 0:
		animation_name = "run"
	if input_y_axis != 0:
		animated_sprite_2d.flip_h = input_y_axis < 0
	animated_sprite_2d.play(animation_name)

func destroy_block():
	#assert is_instance_of()
	var block = ray_cast_2d.get_collider()
	print(block)
	if block != null and typeof(block) == 123:
		block.destroy

