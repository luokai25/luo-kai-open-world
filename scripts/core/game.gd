extends KinematicBody

export var walk_speed = 6.0
export var sprint_speed = 10.0
export var gravity = 24.8
export var jump_force = 9.0
export var dodge_force = 11.0
export var attack_damage = 8

var velocity = Vector3.ZERO
var qi = 0
var qi_max = 100
var body_power = 1
var realm_name = "Mortal"
var inventory = []
var hp = 100
var max_hp = 100
var attack_cooldown = 0.0
var dodge_cooldown = 0.0
var sprint_enabled = false
var inventory_open = false
var nearby_npc = null

onready var camera = null
onready var progression = preload("res://scripts/systems/progression.gd").new()
onready var hud = null
var main_controller = null

func _ready():
	ensure_input_actions()
	camera = get_node_or_null("Camera")
	if camera and camera.has_method("set"):
		camera.set("target_path", get_path())
	hud = get_node_or_null("../../HUD")
	if hud and hud.has_method("bind"):
		hud.bind(self)
	update_from_progression()
	if inventory.empty():
		add_item("Worn Sword")
		add_item("Qi Stone")

func bind_main(main_node):
	main_controller = main_node

func set_nearby_npc(npc):
	nearby_npc = npc
	if hud and hud.has_method("set_dialogue") and npc and npc.has_method("get_interaction_text"):
		hud.set_dialogue(npc.get_interaction_text())
	elif hud and hud.has_method("set_dialogue"):
		hud.set_dialogue("")

func ensure_input_actions():
	_add_key_action("move_forward", KEY_W)
	_add_key_action("move_forward", KEY_UP)
	_add_key_action("move_backward", KEY_S)
	_add_key_action("move_backward", KEY_DOWN)
	_add_key_action("move_left", KEY_A)
	_add_key_action("move_left", KEY_LEFT)
	_add_key_action("move_right", KEY_D)
	_add_key_action("move_right", KEY_RIGHT)
	_add_key_action("attack", KEY_J)
	_add_key_action("dodge", KEY_K)
	_add_key_action("interact", KEY_E)
	_add_key_action("cultivate", KEY_C)
	_add_key_action("train_body", KEY_B)
	_add_key_action("inventory", KEY_I)
	_add_key_action("jump", KEY_SPACE)
	_add_key_action("sprint", KEY_SHIFT)
	_add_key_action("save_game", KEY_F5)

func _add_key_action(action_name, key_code):
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	var event = InputEventKey.new()
	event.scancode = key_code
	InputMap.action_add_event(action_name, event)

func _physics_process(delta):
	attack_cooldown = max(attack_cooldown - delta, 0)
	dodge_cooldown = max(dodge_cooldown - delta, 0)

	var direction = Vector3.ZERO
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		direction.z += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	direction = direction.normalized()

	var speed = sprint_speed if sprint_enabled or Input.is_action_pressed("sprint") else walk_speed
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
	else:
		velocity.y -= gravity * delta

	velocity = move_and_slide(velocity, Vector3.UP)

	if Input.is_action_just_pressed("attack"):
		attack()
	if Input.is_action_just_pressed("cultivate"):
		cultivate()
	if Input.is_action_just_pressed("train_body"):
		train_body(5)
	if Input.is_action_just_pressed("interact"):
		interact()
	if Input.is_action_just_pressed("dodge"):
		dodge(direction)
	if Input.is_action_just_pressed("inventory"):
		toggle_inventory()
	if Input.is_action_just_pressed("save_game") and main_controller:
		main_controller.save_game()

	if hud and hud.has_method("update_values"):
		hud.update_values(self)

func attack():
	if attack_cooldown > 0:
		return
	attack_cooldown = 0.4
	for n in get_tree().get_nodes_in_group("enemies"):
		if n and n.has_method("take_damage") and global_transform.origin.distance_to(n.global_transform.origin) < 4.0:
			n.take_damage(attack_damage + body_power)
			gather_qi(10)
			add_item("Qi Fragment")
			break

func cultivate():
	gather_qi(15)
	add_item("Condensed Qi")

func interact():
	if nearby_npc and nearby_npc.has_method("interact"):
		nearby_npc.interact()
		if hud and hud.has_method("set_dialogue") and nearby_npc.has_method("get_interaction_text"):
			hud.set_dialogue(nearby_npc.get_interaction_text())
	else:
		gather_qi(3)
		add_item("Wild Herb")

func dodge(direction):
	if dodge_cooldown > 0:
		return
	dodge_cooldown = 0.9
	var push = direction
	if push == Vector3.ZERO:
		push = -global_transform.basis.z
	velocity += push.normalized() * dodge_force

func toggle_sprint():
	sprint_enabled = not sprint_enabled
	if hud and hud.has_method("flash_message"):
		hud.flash_message("Sprint on" if sprint_enabled else "Sprint off")

func gather_qi(amount):
	progression.add_qi(amount)
	update_from_progression()

func train_body(amount):
	progression.train_body(amount)
	update_from_progression()

func try_breakthrough():
	progression.breakthrough()
	update_from_progression()

func add_item(item_name):
	inventory.append(item_name)
	if hud and hud.has_method("update_values"):
		hud.update_values(self)
	if inventory_open and hud and hud.has_method("set_inventory_visible"):
		hud.set_inventory_visible(true, inventory_text())

func remove_item(item_name):
	inventory.erase(item_name)
	if hud and hud.has_method("update_values"):
		hud.update_values(self)
	if inventory_open and hud and hud.has_method("set_inventory_visible"):
		hud.set_inventory_visible(true, inventory_text())

func toggle_inventory():
	inventory_open = not inventory_open
	if hud and hud.has_method("set_inventory_visible"):
		hud.set_inventory_visible(inventory_open, inventory_text())

func inventory_text():
	if inventory.empty():
		return "Inventory empty"
	var lines = PoolStringArray()
	for item in inventory:
		lines.append(str(item))
	return lines.join("\n")

func update_from_progression():
	qi = progression.qi
	qi_max = progression.qi_max
	body_power = progression.body_power
	realm_name = progression.realm_name()
	if hud and hud.has_method("update_values"):
		hud.update_values(self)
	if inventory_open and hud and hud.has_method("set_inventory_visible"):
		hud.set_inventory_visible(true, inventory_text())

func get_save_data():
	return {
		"progression": progression.get_state(),
		"inventory": inventory,
		"hp": hp,
		"max_hp": max_hp,
		"position": [global_transform.origin.x, global_transform.origin.y, global_transform.origin.z],
	}

func load_save_data(data):
	if typeof(data) != TYPE_DICTIONARY:
		return
	progression.load_state(data.get("progression", {}))
	inventory = data.get("inventory", inventory)
	hp = int(data.get("hp", hp))
	max_hp = int(data.get("max_hp", max_hp))
	var pos = data.get("position", null)
	if typeof(pos) == TYPE_ARRAY and pos.size() == 3:
		global_transform.origin = Vector3(float(pos[0]), float(pos[1]), float(pos[2]))
	update_from_progression()

func take_damage(amount):
	hp = max(hp - amount, 0)
	if hp == 0 and hud and hud.has_method("flash_message"):
		hud.flash_message("You fell")
