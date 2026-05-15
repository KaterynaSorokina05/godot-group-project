extends Area2D

@export_file("*.tscn") var next_level_path: String
var is_player_near = false 

func _ready():
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.name == "MainHero":
		is_player_near = true 

func _on_body_exited(body):
	if body.name == "MainHero":
		is_player_near = false 


func _process(delta):
	
	if is_player_near and Input.is_action_just_pressed("ui_accept"):
		change_level()

func change_level():
	if next_level_path == "":
		print("Путь к следующему уровню не задан!")
		return
	
	Transition.change_scene(next_level_path)
