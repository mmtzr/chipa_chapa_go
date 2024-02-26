extends Camera3D

# exports
@export var distance = 4.0
@export var height = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	# set camera independent from the parent
	set_physics_process(true)
	set_as_top_level(true)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var target = get_parent().get_global_position()
	var pos = get_global_position()
	var up = Vector3(0,1,0)
	
	var offset = pos - target
	offset = offset.normalized()*distance
	offset.y = height
	
	pos = target + offset # final camera position
	look_at_from_position(pos, target, up)
	
