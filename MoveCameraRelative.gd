extends Node3D

@export var camera : Camera3D
@export var action_move_forward := 'cam_move_forward'
@export var action_move_backward := 'cam_move_backward'
@export var action_move_left := 'cam_move_left'
@export var action_move_right := 'cam_move_right'
@export var move_speed : float = 10

var _moveIntent : Vector3 = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input(delta)
	process_movement(delta)

func process_input(delta: float):	
	_moveIntent = Vector3.ZERO
	if (Input.is_action_pressed(action_move_forward)):
		_moveIntent += Vector3.FORWARD * move_speed
	if (Input.is_action_pressed(action_move_backward)):
		_moveIntent += Vector3.BACK * move_speed
	if (Input.is_action_pressed(action_move_left)):
		_moveIntent += Vector3.LEFT * move_speed
	if (Input.is_action_pressed(action_move_right)):
		_moveIntent += Vector3.RIGHT * move_speed
	
func process_movement(delta: float):
	var cam_z = camera.transform.basis.z
	cam_z.y = 0;
	cam_z.normalized()
	var cam_x = camera.transform.basis.x	
	cam_x.y = 0;
	cam_x.normalized()
	translate((cam_z * _moveIntent.z + cam_x * _moveIntent.x).normalized() * move_speed * delta)
