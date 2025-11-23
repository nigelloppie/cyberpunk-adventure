@tool
extends "res://addons/level_block/level_block_node.gd"
@onready var lights_out_menu = $"../../CanvasLayer/LightsOutMenu"

func _ready():
	lights_out_menu.puzzle_solved.connect(_on_puzzle_solved)
	GameManager.door_1 = self
	if SaveData.is_action_done("door_1_unlocked"):
		west_face = -1
		
func _on_puzzle_solved():
		self.west_face = -1
		SaveData.mark_action_done("door_1_unlocked")
		GameManager.save()
