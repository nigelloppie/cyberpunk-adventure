extends Node
var player: Node = null
var door_1: Node = null
var player_scene_path = "res://scenes/entity/player.tscn"
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("f5"):
		save()
		
	if event.is_action_pressed("f2"):
		if SaveData.load():
			reload_scene_with_save()
			
	if event.is_action_pressed("f3"):
		door_1.west_face = 3
		SaveData.mark_action_not_done("door_1_unlocked")
		save()
		
func save():
	SaveData.data["player"] = {
		"position": var_to_str(player.global_position),
		"rotation": var_to_str(player.global_rotation)
	}
	SaveData.save()
	
func reload_scene_with_save():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
