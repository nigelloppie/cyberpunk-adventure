extends Node3D

const TRAVEL_TIME := 0.3

@onready var front_ray := $FrontRay
@onready var back_ray := $BackRay

var tween

func _physics_process(_delta: float) -> void:
	if tween is Tween:
		if tween.is_running():
			return
	if Input.is_action_pressed("forward") and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)

	if Input.is_action_pressed("back") and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)

	if Input.is_action_pressed("left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)

	if Input.is_action_pressed("right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
		
func _ready() -> void:
	SaveData.load()
	var player_data = SaveData.data.get("player")
	if player_data:
		global_position = str_to_var(player_data["position"])
		global_rotation = str_to_var(player_data["rotation"])
	GameManager.player = self
	
