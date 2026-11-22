extends Node2D

## Starter game loop. Replace with your own scenes and systems.
## Click (or press Space) to increase the score.
## Tuning values come from the JSON file at [member config_path] (see GameConfig).

## Path to the external tuning file. Change it in the inspector to swap configs.
@export var config_path := "res://data/game_config.json"

## Current score.
var score := 0

var _label: Label
var _score_step := 1


## Creates the score label and applies the loaded configuration.
func _ready() -> void:
	_label = Label.new()
	add_child(_label)
	apply_config(GameConfig.load_from(config_path))
	_update_label()


## Applies tuning values (see GameConfig.DEFAULTS for keys) to the label and scoring.
## Expects the node to be ready, because it updates the child label.
func apply_config(config: Dictionary) -> void:
	var pos: Array = config["label_position"]
	_label.position = Vector2(pos[0], pos[1])
	_label.add_theme_font_size_override("font_size", int(config["label_font_size"]))
	_score_step = int(config["score_step"])


## Handles mouse clicks and the Space key as score input.
func _unhandled_input(event: InputEvent) -> void:
	var clicked := false
	if event is InputEventMouseButton:
		clicked = event.pressed

	var spaced := false
	if event is InputEventKey:
		spaced = event.pressed and not event.echo and event.keycode == KEY_SPACE

	if clicked or spaced:
		score += _score_step
		_update_label()


## Refreshes the on-screen score text.
func _update_label() -> void:
	_label.text = "Score: %d\nClick or press Space" % score
