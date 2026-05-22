extends Node2D

func _ready():
# 1. ЗАБОРОНЯЄМО ГЕРОЮ ХОДИТИ І ДУМАТИ!

	# 3. Плавна поява лісу (чорний екран зникає)
	var tween_fade_in = create_tween()
	tween_fade_in.tween_property($CutsceneUI/ColorRect, "modulate:a", 0.0, 1.0)
	await tween_fade_in.finished

	
	GlobalMusic.play_music("res://scene/forest/F2.wav")
	$CutsceneUI/ColorRect.modulate.a = 1.0
	$CutsceneUI/Label.text = "скоро правда буде розкрита... to be continued"
	$CutsceneUI.visible = true
	
	# Чекаємо 3 секунди
	await get_tree().create_timer(3.0, false).timeout
	$CutsceneUI/Label.text = ""
	Transition.change_scene("res://scene/school/titru.tscn")
	

func _input(event: InputEvent) -> void:
	# Перевіряємо, чи була натиснута клавіша Пробіл (Space)
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
		# Робимо плавний перехід на наступну сцену
		Transition.change_scene("res://scene/school/titru.tscn")
