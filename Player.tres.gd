extends KinematicBody

var speed : int = 10
var direction : Vector3 = Vector3.ZERO
var jump_power : int = 12
var gravity : float = -9.8 * 2
var cam_sens : float = 0.25

onready var cam : Camera = $Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		cam.rotate_x(-deg2rad(event.relative.y) * cam_sens) 
		cam.rotation.x = clamp(cam.rotation.x, -0.60, 0.60)
		rotate_y(-deg2rad(event.relative.x) * cam_sens)

func _physics_process(delta):
	direction.x = Input.get_axis("left", "right") * speed 
	direction.z = Input.get_axis("forward", "backward") * speed 
	
	direction.y += gravity * delta
	direction.y = clamp(direction.y, gravity, -gravity)
	
	move_and_slide(global_transform.basis * direction, Vector3.UP)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		direction.y = jump_power
