extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusic.play_music("res://scene/forest/F2.wav")
	await get_tree().create_timer(3.0, false).timeout
	Transition.change_scene("res://scene/school/after_hit.tscn")

func _input(event: InputEvent) -> void:
	# Перевіряємо, чи була натиснута клавіша Пробіл (Space)
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
		# Робимо плавний перехід на наступну сцену
		Transition.change_scene("res://scene/school/after_hit.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
