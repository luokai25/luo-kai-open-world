extends Spatial

export var zone_name = "Spirit Forest"
export var zone_level = 1
export var qi_density = 1.0
export var realm_theme = "mortal"
export(Array, String) var landmark_names = [
	"Village Edge Gate",
	"Broken Spirit Bridge",
	"Moss Shrine",
]

func get_zone_summary():
	return "%s | Lv %s | Qi %.1f | %s" % [zone_name, zone_level, qi_density, realm_theme]

func get_zone_profile():
	return {
		"name": zone_name,
		"level": zone_level,
		"qi_density": qi_density,
		"realm_theme": realm_theme,
		"landmarks": landmark_names,
	}
