extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_new_game_btn_pressed() -> void:
	# Обязательно сбрасываем координаты героя, если он играл до этого!
	Global.floor_1_position = Vector2.ZERO 
	
	# Используем твою шторку, чтобы красиво перейти в ПЕРВУЮ сцену игры.
	# (Я написал путь к лесу, но если игра начинается со школы - поменяй путь)
	Transition.change_scene("res://scene/forest/forest_scene.tscn")


func _on_continue_btn_pressed() -> void:
	
	# Просим Глобальный скрипт прочитать файл
	var saved_scene = Global.load_game()
	
	# Если файл есть и сцена не пустая:
	if saved_scene != "":
		# Переходим на сохраненную сцену через твою шторку!
		Transition.change_scene(saved_scene)
	else:
		print("Сохранений пока нет! Начни новую игру.")
	# Пока у нас нет системы сохранений в файл, просто выведем текст в консоль
	# print("Игрок нажал 'Продолжить'. Тут будет система загрузки!")
	
	# Как временная мера - можешь перекидывать игрока туда, где сейчас работаешь
	# Transition.change_scene("res://scene/school/school_first_floor.tscn")

func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_characters_btn_pressed() -> void:
	Transition.change_scene("res://Images/characters/characters.tscn")
