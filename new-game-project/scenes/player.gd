extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = -300
		
	if Input.is_action_just_pressed("move_down") and not is_on_floor():
		velocity.y = 300

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction and is_on_floor():
		velocity.x = direction * SPEED
	elif direction and not is_on_floor():
		velocity.x = direction * (SPEED / 1.5)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	

	move_and_slide()
