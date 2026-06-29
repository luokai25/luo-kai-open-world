extends Camera

export(NodePath) var target_path
export var distance = 5.5
export var height = 2.2
export var follow_speed = 8.0
export var mouse_sensitivity = 0.2

var target
var yaw = 180.0
var pitch = -18.0

func _ready():
	if target_path != NodePath(""):
		target = get_node_or_null(target_path)

func _process(delta):
	if not target:
		return
	var desired = target.global_transform.origin
	desired.y += height
	var offset = Vector3()
	offset.z = distance
	var basis = Basis(Vector3.UP, deg2rad(yaw)) * Basis(Vector3.RIGHT, deg2rad(pitch))
	var camera_pos = desired + basis.xform(offset)
	global_transform.origin = global_transform.origin.linear_interpolate(camera_pos, follow_speed * delta)
	look_at(desired, Vector3.UP)
