@tool
extends "res://addons/level_block/level_block_node.gd"

func _ready():
	GameManager.door_1 = self
	if SaveData.is_action_done("door_1_unlocked"):
		west_face = -1
