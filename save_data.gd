extends Node

var data: Dictionary = {
	"completed_actions": {}, # Stores flags like "quest_done": true
	"player": {
		"position": Vector3.ZERO,
		"rotation": Vector3.ZERO
	}
}

func mark_action_done(action_name: String):
	data["completed_actions"][action_name] = true
	
func mark_action_not_done(action_name: String):
	data["completed_actions"][action_name] = false

func is_action_done(action_name: String) -> bool:
	return data["completed_actions"].get(action_name, false)

func save():
	var json_string := JSON.stringify(data)
	var file := FileAccess.open("res://save.json", FileAccess.WRITE)
	file.store_string(json_string)
	file.close()

func load():
	if not FileAccess.file_exists("res://save.json"):
		return false

	var file := FileAccess.open("res://save.json", FileAccess.READ)
	var text := file.get_as_text()
	file.close()

	var result = JSON.parse_string(text)
	if typeof(result) == TYPE_DICTIONARY:
		data = result
		return true
	return false
