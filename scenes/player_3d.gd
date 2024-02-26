extends CharacterBody3D

var gravity = -9.8
var camera
var anim_player
var character

const SPEED = 6
const ACCELERATION = 3
const DE_ACCELERATION = 5

func _ready():
	anim_player = get_node("Animations_Player3D")
	character = get_node(".")
	
func _physics_process(delta):
	camera = get_node("Marker3D/Camera3D").get_global_transform()
	var dir = Vector3()
	var is_moving = false
	
	
	if (Input.is_action_pressed("move_up")):
		dir += -camera.basis[2]
		is_moving = true
	if (Input.is_action_pressed("move_down")):
		dir += +camera.basis[2]
		is_moving = true
	if (Input.is_action_pressed("move_left")):
		dir += -camera.basis[0]
		is_moving = true
	if (Input.is_action_pressed("move_right")):
		dir += +camera.basis[0]
		is_moving = true

		
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * SPEED
	var accel = DE_ACCELERATION
	
	if (dir.dot(hv) > 0):
		accel = ACCELERATION
		
	# interpolate between acceleration and deacceleration
	hv = hv.lerp(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	move_and_slide()
	
	# get direction
	if (is_moving):
		var angle = atan2(hv.x, hv.z)
		var char_rot = character.get_rotation()
		char_rot.y = angle
		character.set_rotation(char_rot)
	
	# set animation depending on movement status and rotation
	# var speed = hv.length() / SPEED # normalized speed
	
	get_node("IdleWalkRunTree").set("parameters/blend_position",hv)
		

