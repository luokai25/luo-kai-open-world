extends CanvasLayer

onready var hp_label = null
onready var qi_label = null
onready var body_label = null
onready var realm_label = null
onready var zone_label = null
onready var world_label = null
onready var dialogue_label = null
onready var inventory_label = null
onready var inventory_details = null
onready var message_label = null
onready var landmark_label = null
onready var request_label = null
onready var intro_layer = null
onready var intro_title = null
onready var intro_subtitle = null
onready var intro_hint = null

func _ready():
	bind(get_parent().get_node_or_null("World/Player"), get_parent().get_node_or_null("World/WorldState"))

func bind(player, world_state = null):
	if has_node("HpLabel"):
		hp_label = $HpLabel
	if has_node("QiLabel"):
		qi_label = $QiLabel
	if has_node("BodyLabel"):
		body_label = $BodyLabel
	if has_node("RealmLabel"):
		realm_label = $RealmLabel
	if has_node("ZoneLabel"):
		zone_label = $ZoneLabel
	if has_node("WorldLabel"):
		world_label = $WorldLabel
	if has_node("LandmarkLabel"):
		landmark_label = $LandmarkLabel
	if has_node("DialogueLabel"):
		dialogue_label = $DialogueLabel
	if has_node("RequestLabel"):
		request_label = $RequestLabel
	if has_node("InventoryLabel"):
		inventory_label = $InventoryLabel
	if has_node("InventoryDetails"):
		inventory_details = $InventoryDetails
	if has_node("MessageLabel"):
		message_label = $MessageLabel
	if has_node("IntroLayer"):
		intro_layer = $IntroLayer
	if has_node("IntroLayer/IntroTitle"):
		intro_title = $IntroLayer/IntroTitle
	if has_node("IntroLayer/IntroSubtitle"):
		intro_subtitle = $IntroLayer/IntroSubtitle
	if has_node("IntroLayer/IntroHint"):
		intro_hint = $IntroLayer/IntroHint
	update_values(player, world_state)

func update_values(player, world_state = null):
	if not player:
		return
	if hp_label:
		hp_label.text = "HP: %s / %s" % [player.hp, player.max_hp]
	if qi_label:
		qi_label.text = "Qi: %s / %s" % [player.qi, player.qi_max]
	if body_label:
		body_label.text = "Body: %s (Tier %s)" % [player.body_power, player.progression.body_tier]
	if realm_label:
		realm_label.text = "Realm: %s" % player.realm_name
	if inventory_label:
		inventory_label.text = "Inventory: %s items" % player.inventory.size()
	if world_label and world_state:
		world_label.text = world_state.get_living_world_text()
	elif world_label:
		world_label.text = "World: calm"
	if zone_label and player.get_parent() and player.get_parent().has_method("get_zone_summary"):
		zone_label.text = player.get_parent().get_zone_summary()
	if landmark_label and player.get_parent() and player.get_parent().has_method("get_zone_profile"):
		landmark_label.text = player.get_parent().get_zone_profile().get("landmarks", []).join(" • ")

func set_zone_text(text):
	if zone_label:
		zone_label.text = text

func set_world_text(text):
	if world_label:
		world_label.text = text

func set_landmark_text(text):
	if landmark_label:
		landmark_label.text = text

func set_dialogue(text):
	if dialogue_label:
		dialogue_label.text = text

func set_request_text(text):
	if request_label:
		request_label.text = text

func set_inventory_visible(visible, text=""):
	if inventory_details:
		inventory_details.visible = visible
		inventory_details.text = text if text != "" else "Inventory empty"

func set_intro_visible(visible, title = "", subtitle = "", hint = ""):
	if intro_title and title != "":
		intro_title.text = title
	if intro_subtitle and subtitle != "":
		intro_subtitle.text = subtitle
	if intro_hint and hint != "":
		intro_hint.text = hint
	if intro_layer:
		intro_layer.visible = visible

func flash_message(text):
	if message_label:
		message_label.text = text
