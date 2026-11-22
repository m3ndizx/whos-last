class_name GameConfig
extends RefCounted

## Loads gameplay tuning values from an external JSON file.
## A missing or malformed file falls back to the built-in defaults, so the game
## always starts. Keys in the file that are not in DEFAULTS are ignored.

## Built-in fallback values. Every key here is a tunable; the JSON file overrides them.
const DEFAULTS := {
	"label_position": [40, 40],
	"label_font_size": 32,
	"score_step": 1,
}


## Returns the defaults merged with the values found at [param path].
static func load_from(path: String) -> Dictionary:
	var result: Dictionary = DEFAULTS.duplicate(true)
	if not FileAccess.file_exists(path):
		push_warning("GameConfig: %s not found, using defaults" % path)
		return result

	var parsed: Variant = JSON.parse_string(FileAccess.get_file_as_string(path))
	if not parsed is Dictionary:
		push_warning("GameConfig: %s is not a JSON object, using defaults" % path)
		return result

	for key in parsed:
		if result.has(key):
			result[key] = parsed[key]
	return result
