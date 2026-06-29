extends Node

const REALMS = [
	"Mortal",
	"Qi Gathering",
	"Foundation Establishment",
	"Core Formation",
	"Nascent Soul",
	"Soul Formation",
	"Void Refinement",
	"Body Integration",
	"Mahayana",
	"Tribulation",
]

var qi = 0
var qi_max = 100
var body_power = 1
var realm_index = 0
var body_tier = 1

func realm_name():
	return REALMS[realm_index]

func add_qi(amount):
	qi = clamp(qi + amount, 0, qi_max)
	if qi >= qi_max:
		breakthrough()

func breakthrough():
	if realm_index < REALMS.size() - 1:
		realm_index += 1
		qi = 0
		qi_max = int(qi_max * 1.5)

func train_body(amount):
	body_power += amount
	var new_tier = int(body_power / 100) + 1
	if new_tier > body_tier:
		body_tier = new_tier

func get_state():
	return {
		"qi": qi,
		"qi_max": qi_max,
		"body_power": body_power,
		"realm_index": realm_index,
		"body_tier": body_tier,
	}

func load_state(data):
	if typeof(data) != TYPE_DICTIONARY:
		return
	qi = int(data.get("qi", qi))
	qi_max = int(data.get("qi_max", qi_max))
	body_power = int(data.get("body_power", body_power))
	realm_index = int(data.get("realm_index", realm_index))
	body_tier = int(data.get("body_tier", body_tier))
