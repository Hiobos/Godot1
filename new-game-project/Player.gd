extends CharacterBody3D

@export var speed: float = 5.0
@export var jump_velocity: float = 4.5

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var direction = Vector3.ZERO

	if Input.is_action_pressed("ui_up"):
		direction -= transform.basis.z
	if Input.is_action_pressed("ui_down"):
		direction += transform.basis.z
	if Input.is_action_pressed("ui_left"):
		direction -= transform.basis.x
	if Input.is_action_pressed("ui_right"):
		direction += transform.basis.x

	direction = direction.normalized()
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity

	move_and_slide()
