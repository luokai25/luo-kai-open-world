extends KinematicBody

export var hp = 25
export var attack_damage = 4
export var speed = 3.5

var velocity = Vector3.ZERO
var target = null
var attack_cooldown = 0.0

func _ready():
	add_to_group("enemies")

func _physics_process(delta):
	attack_cooldown = max(attack_cooldown - delta, 0)
	if not target:
		return
	var to_target = target.global_transform.origin - global_transform.origin
	var distance = to_target.length()
	if distance > 1.75:
		var direction = to_target.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0
		velocity.z = 0
		if attack_cooldown == 0 and target.has_method("take_damage"):
			target.take_damage(attack_damage)
			attack_cooldown = 1.0
	velocity.y -= 24.8 * delta
	velocity = move_and_slide(velocity, Vector3.UP)

func set_target(new_target):
	target = new_target

func take_damage(amount):
	hp -= amount
	if hp <= 0:
		queue_free()
