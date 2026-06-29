extends Node

export var minutes_per_real_second = 12.0
export var start_time_minutes = 360
export var season_index = 0
export var base_region_name = "Spirit Forest"

var time_minutes = 360.0
var day_count = 1
var weather = "clear"
var weather_timer = 0.0
var region_stability = 0.65
var spiritual_pressure = 0.25
var world_threat = 0.15
var settlement_activity = 0.7
var landmarks = ["Village Edge Gate", "Moss Shrine", "Old River Bridge"]
var world_events = []
var npc_routines = {}

const SEASONS = ["Spring", "Summer", "Autumn", "Winter"]
const WEATHER_TABLE = {
	0: ["clear", "clear", "clear", "fog", "rain"],
	1: ["clear", "clear", "rain", "storm", "fog"],
	2: ["clear", "fog", "rain", "wind", "clear"],
	3: ["clear", "fog", "snow", "wind", "clear"],
}

func _ready():
	randomize()
	time_minutes = float(start_time_minutes)
	weather = "clear"
	weather_timer = 30.0
	seed_world()

func _process(delta):
	advance_time(delta)
	weather_timer -= delta
	if weather_timer <= 0:
		roll_weather()
	update_world_pressure(delta)

func seed_world():
	world_events.clear()
	world_events.append({"kind": "rumor", "text": "A shrine in the forest still burns incense at dusk."})
	world_events.append({"kind": "rumor", "text": "Travelers say the ridge path changes after rain."})
	npc_routines = {
		"elder": ["shrine", "gate", "home"],
		"merchant": ["road", "market", "inn"],
		"hunter": ["forest", "camp", "forest"],
		"trainer": ["dojo", "yard", "dojo"],
	}

func advance_time(delta):
	time_minutes += delta * minutes_per_real_second
	while time_minutes >= 1440:
		time_minutes -= 1440
		day_count += 1
		if day_count % 7 == 0:
			season_index = (season_index + 1) % SEASONS.size()

func roll_weather():
	var table = WEATHER_TABLE.get(season_index, WEATHER_TABLE[0])
	weather = table[int(rand_range(0, table.size()))]
	weather_timer = rand_range(20.0, 45.0)

func update_world_pressure(delta):
	var hour = int(time_minutes) / 60
	if hour >= 20 or hour < 5:
		settlement_activity = max(settlement_activity - delta * 0.01, 0.1)
		world_threat = min(world_threat + delta * 0.005, 1.0)
	else:
		settlement_activity = min(settlement_activity + delta * 0.01, 1.0)
		world_threat = max(world_threat - delta * 0.003, 0.05)
	if weather in ["storm", "fog", "snow"]:
		spiritual_pressure = min(spiritual_pressure + delta * 0.01, 1.0)
	else:
		spiritual_pressure = max(spiritual_pressure - delta * 0.005, 0.1)

func get_time_text():
	var hour = int(time_minutes) / 60
	var minute = int(time_minutes) % 60
	return "%02d:%02d" % [hour, minute]

func get_day_period():
	var hour = int(time_minutes) / 60
	if hour >= 5 and hour < 8:
		return "Dawn"
	if hour >= 8 and hour < 12:
		return "Morning"
	if hour >= 12 and hour < 17:
		return "Afternoon"
	if hour >= 17 and hour < 20:
		return "Evening"
	return "Night"

func is_night():
	var hour = int(time_minutes) / 60
	return hour >= 20 or hour < 5

func get_summary():
	return "%s • %s • %s • Day %s" % [SEASONS[season_index], get_day_period(), weather, day_count]

func get_world_density():
	return {
		"region_stability": region_stability,
		"spiritual_pressure": spiritual_pressure,
		"world_threat": world_threat,
		"settlement_activity": settlement_activity,
	}

func get_landmark_text():
	return landmarks.join(" • ")

func get_living_world_text():
	return "Time %s | %s | Pressure %.2f | Threat %.2f" % [get_time_text(), weather, spiritual_pressure, world_threat]
