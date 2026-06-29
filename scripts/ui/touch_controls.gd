extends CanvasLayer

onready var attack_button = null
onready var dodge_button = null
onready var interact_button = null
onready var cultivate_button = null
onready var body_button = null
onready var inventory_button = null
onready var save_button = null
onready var jump_button = null
onready var sprint_button = null

var player = null
var main = null

func _ready():
	attack_button = get_node_or_null("AttackButton")
	dodge_button = get_node_or_null("DodgeButton")
	interact_button = get_node_or_null("InteractButton")
	cultivate_button = get_node_or_null("CultivateButton")
	body_button = get_node_or_null("BodyButton")
	inventory_button = get_node_or_null("InventoryButton")
	save_button = get_node_or_null("SaveButton")
	jump_button = get_node_or_null("JumpButton")
	sprint_button = get_node_or_null("SprintButton")
	_connect_button(attack_button, "_on_attack_pressed")
	_connect_button(dodge_button, "_on_dodge_pressed")
	_connect_button(interact_button, "_on_interact_pressed")
	_connect_button(cultivate_button, "_on_cultivate_pressed")
	_connect_button(body_button, "_on_body_pressed")
	_connect_button(inventory_button, "_on_inventory_pressed")
	_connect_button(save_button, "_on_save_pressed")
	_connect_button(jump_button, "_on_jump_pressed")
	_connect_button(sprint_button, "_on_sprint_pressed")

func bind(target_player, target_main):
	player = target_player
	main = target_main

func _connect_button(button, method_name):
	if button and not button.is_connected("pressed", self, method_name):
		button.connect("pressed", self, method_name)

func _on_attack_pressed():
	if player:
		player.attack()

func _on_dodge_pressed():
	if player:
		player.dodge(Vector3(0, 0, -1))

func _on_interact_pressed():
	if player:
		player.interact()

func _on_cultivate_pressed():
	if player:
		player.cultivate()

func _on_body_pressed():
	if player:
		player.train_body(10)

func _on_inventory_pressed():
	if player:
		player.toggle_inventory()

func _on_save_pressed():
	if main and main.has_method("save_game"):
		main.save_game()

func _on_jump_pressed():
	if player:
		player.velocity.y = player.jump_force

func _on_sprint_pressed():
	if player and player.has_method("toggle_sprint"):
		player.toggle_sprint()
