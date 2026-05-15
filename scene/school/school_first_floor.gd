extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.save_game(scene_file_path)
	if Global.floor_1_position != Vector2.ZERO:
		
		$main_hero.global_position = Global.floor_1_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_up_pressed() -> void:
	
	Transition.change_scene("res://scene/school/school_second_floor.tscn")
	
