extends Node

onready var world = $World
onready var world_state = $WorldState
onready var player = $World/Player
onready var enemy = $World/Enemy
onready var npc = $World/NPC
onready var hud = $HUD
onready var touch_controls = $TouchControls

func _ready():
	add_to_group("main_controller")
	if enemy and enemy.has_method("set_target"):
		enemy.set_target(player)
	if npc and npc.has_method("set_player"):
		npc.set_player(player)
	if player and player.has_method("bind_main"):
		player.bind_main(self)
	if hud and hud.has_method("bind"):
		hud.bind(player, world_state)
	if touch_controls and touch_controls.has_method("bind"):
		touch_controls.bind(player, self)
	if world and world.has_method("get_zone_profile"):
		_apply_world_profile(world.get_zone_profile())
	load_game()
	if hud and hud.has_method("flash_message"):
		hud.flash_message("Luo Kai: Open World ready")

func _apply_world_profile(profile):
	if not hud or typeof(profile) != TYPE_DICTIONARY:
		return
	if hud.has_method("set_zone_text"):
		hud.set_zone_text("%s | Lv %s | Qi %.1f | %s" % [profile.get("name", "World"), profile.get("level", 1), profile.get("qi_density", 1.0), profile.get("realm_theme", "")])
	if hud.has_method("set_landmark_text"):
		hud.set_landmark_text(profile.get("landmarks", []).join(" • "))

func save_game():
	if not player:
		return
	var data = {
		"player": player.get_save_data(),
		"zone": world.get_zone_summary() if world and world.has_method("get_zone_summary") else "",
		"world": world_state.get_summary() if world_state and world_state.has_method("get_summary") else "",
		"world_density": world_state.get_world_density() if world_state and world_state.has_method("get_world_density") else {},
		"landmarks": world_state.get_landmark_text() if world_state and world_state.has_method("get_landmark_text") else "",
	}
	var file = File.new()
	if file.open("user://open_world_save.json", File.WRITE) != OK:
		return
	file.store_string(to_json(data))
	file.close()
	if hud and hud.has_method("flash_message"):
		hud.flash_message("Game saved")

func load_game():
	var file = File.new()
	if not file.file_exists("user://open_world_save.json"):
		return
	if file.open("user://open_world_save.json", File.READ) != OK:
		return
	var text = file.get_as_text()
	file.close()
	var parsed = JSON.parse(text)
	if parsed.error != OK or typeof(parsed.result) != TYPE_DICTIONARY:
		return
	var data = parsed.result
	if player and player.has_method("load_save_data"):
		player.load_save_data(data.get("player", {}))
	if hud and hud.has_method("flash_message"):
		hud.flash_message("Save loaded")
