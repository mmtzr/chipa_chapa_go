extends CharacterBody3D

@export var fall_speed = 10
@export var walk_speed = 6
@export var jump_speed = 20

const ACCELERATION = 3
const DE_ACCELERATION = 5



func _ready():
	$Animations_Player3D.play("IdleD")
	

func _physics_process(delta):
	# We create a local variable to store the input direction.
	var direction = Vector3.ZERO
	var play_velocity = Vector3.ZERO
	
	# We check for each move input and update the direction accordingly.
	# In 3D, the XZ plane is the ground plane.
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.z += 1
	if Input.is_action_pressed("move_up"):
		direction.z -= 1

	# in case of diagonal movement, normalize so it's npt faster
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		
	# Ground Velocity
	play_velocity.x = lerp(play_velocity.x, direction.x * walk_speed, 1)
	play_velocity.z = lerp(play_velocity.z, direction.z * walk_speed, 1)

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor.
		play_velocity.y = play_velocity.y - (fall_speed * delta)
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		play_velocity.y = jump_speed
	# Moving the Character
	velocity = play_velocity

	move_and_slide()
	
	var blendPosition = Vector2(velocity.normalized().x,-velocity.normalized().z)
	$IdleWalkRunTree.set("parameters/blend_position",blendPosition)
	
	print(blendPosition)
