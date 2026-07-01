extends Area

enum RequestType {
	QUEST,
	DELIVER,
	HUNT,
	TRAIN,
	ELDER_TALK,
	ARTIFACT,
}

export(String) var npc_name = "Elder Shen"
export(String) var dialogue = "The road is long."
export(int, "Quest", "Deliver", "Hunt", "Train", "Talk", "Artifact") var request_type = 0
export(String) var request_text = "Bring me 3 Qi Stones."
export(String) var reward_text = "Qi + Body"
export(String) var required_item = "Qi Stone"
export(int) var required_count = 3
export(int) var reward_qi = 20
export(int) var reward_body = 5
export(String) var reward_item = ""
export(String) var followup_dialogue = "Return when you are ready for more."

var player = null
var fulfilled = false
var accepted = false
var request_id = "elder_shen_qi_stones"
var affinity = 0

func set_player(target_player):
	player = target_player

func _ready():
	add_to_group("npcs")
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")
	set_process_input(true)

func _input(event):
	if player and event.is_action_pressed("interact"):
		interact()

func _on_body_entered(body):
	if body and body.has_method("set_nearby_npc"):
		player = body
		player.set_nearby_npc(self)
		show_dialogue()

func _on_body_exited(body):
	if body == player:
		if player and player.has_method("set_nearby_npc"):
			player.set_nearby_npc(null)
		player = null

func get_interaction_text():
	if fulfilled:
		return "%s: %s" % [npc_name, followup_dialogue]
	if accepted:
		return "%s: %s" % [npc_name, request_text]
	return "%s: %s" % [npc_name, dialogue]

func show_dialogue():
	var hud = get_tree().get_root().find_node("HUD", true, false)
	if hud and hud.has_method("set_dialogue"):
		hud.set_dialogue(get_interaction_text())
	if hud and hud.has_method("flash_message"):
		hud.flash_message(request_text if not fulfilled else reward_text)

func interact():
	if not player:
		return
	if fulfilled:
		show_dialogue()
		return
	accepted = true
	if _can_complete(player):
		_complete_request(player)
	else:
		_show_need_more()

func _can_complete(target):
	match request_type:
		RequestType.QUEST, RequestType.DELIVER, RequestType.ARTIFACT:
			return target.inventory.count(required_item) >= required_count
		RequestType.HUNT, RequestType.TRAIN, RequestType.ELDER_TALK:
			return true
		_:
			return false

func _show_need_more():
	var hud = get_tree().get_root().find_node("HUD", true, false)
	if hud and hud.has_method("flash_message"):
		hud.flash_message("%s needs %s x%s" % [npc_name, required_item, required_count])

func _complete_request(target):
	fulfilled = true
	accepted = true
	if request_type in [RequestType.QUEST, RequestType.DELIVER, RequestType.ARTIFACT]:
		for i in range(required_count):
			target.remove_item(required_item)
	if reward_qi > 0:
		target.gather_qi(reward_qi)
	if reward_body > 0:
		target.train_body(reward_body)
	if reward_item != "":
		target.add_item(reward_item)
	affinity += 1
	var hud = get_tree().get_root().find_node("HUD", true, false)
	if hud and hud.has_method("flash_message"):
		hud.flash_message("%s rewards you: %s" % [npc_name, reward_text])
	if hud and hud.has_method("set_dialogue"):
		hud.set_dialogue("%s: %s" % [npc_name, followup_dialogue])
