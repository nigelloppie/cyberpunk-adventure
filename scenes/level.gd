extends Node3D

func _ready() -> void:
	print("LOAD SAVE")
	SaveData.load()

func _open_secret_door():
	print("Puzzle solved!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("f4"):
		$CanvasLayer/LightsOutMenu.open_menu()
