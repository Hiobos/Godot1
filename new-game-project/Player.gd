extends CharacterBody3D

const SPEED = 5.0
const SPRINT = 8.0
const JUMP_VELOCITY = 4.5
const SENSIVITY = 0.005

var gravity = 9.8

@onready var head = $head
@onready var camera = $head/Camera3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSIVITY)
		camera.rotate_x(-event.relative.y * SENSIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	#adding gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	#handling jumps
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#handling sprint
	if Input.is_action_just_pressed("Sprint"):
		velocity.x = SPRINT
	else:
		velocity.x = SPEED
	
	#input directions and ahndle movement
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()
