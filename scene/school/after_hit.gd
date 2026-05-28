extends Node2D

func _ready():
	# БЕЗУПРЕЧНЫЙ СПОСОБ: Говорим движку самому найти камеру в этой сцене
	var camera = find_child("Camera2D", true, false)
	
	# Проверяем, нашлась ли камера, чтобы игра точно не вылетала
	if camera != null:
		camera.limit_left = -710   # Ограничение слева
		camera.limit_right = 1120  # Ограничение справа
		camera.limit_top = -400    # Ограничение сверху
		camera.limit_bottom = 400  # Ограничение снизу
	
# 1. ЗАБОРОНЯЄМО ГЕРОЮ ХОДИТИ І ДУМАТИ!
	GlobalMusic.play_music("res://sountrack/school.wav")
	Global.save_game(scene_file_path)
	
	$Sprite2D/MainHero/AnimatedSprite2D.flip_h = false
	$Sprite2D/pers4/AnimatedSprite2D.flip_h = true
	# Маленька пауза перед початком діалогу, щоб гравець встиг роздивитися сцену
	await get_tree().create_timer(1.0, false).timeout
	
	# === ДІАЛОГ ===
	# Формат: Ім'я, Текст, Вузол Спрайту, Анімація розмови, Анімація спокою
	
	await play_line("ЛОЛІТА", "Брайане... ти як? Ти весь тремтиш. Боже, він зовсім з’їхав з глузду. ", $Sprite2D/pers4/AnimatedSprite2D, "talk_left", "default_left")
	
	await play_line("БРАЙН", "*Важко дихаючи* Все... нормально. Він просто боїться. Треба знайти Грейс, щоб вона допомогла відкрити шафку", $Sprite2D/MainHero/AnimatedSprite2D, "talk_right", "default_right")
	   
	DialogueManager.hide_text()
	
	#Transition.change_scene("res://scene/forest/new_forest.tscn")
	# === КІНЕЦЬ СЦЕНИ ===
	# Тут ти можеш завантажити наступний день (наприклад, школу)
	# Transition.change_scene("res://school_first_floor.tscn")
	$Sprite2D/MainHero.set_physics_process(true)
	$Sprite2D/pers4/CollisionShape2D.disabled = true

	
	
	
	
	
	

# ==========================================
# ПОКРАЩЕНА ФУНКЦІЯ ДЛЯ АНІМАЦІЇ ПЕРСОНАЖІВ
# ==========================================
func play_line(char_name: String, text: String, sprite: AnimatedSprite2D, talk_anim: String, idle_anim: String):
	# 1. Показуємо текст
	DialogueManager.show_text(char_name, text)
	
	# 2. Якщо вказали спрайт - вмикаємо анімацію розмови
	if sprite != null:
		sprite.play(talk_anim)
		
	# 3. Чекаємо кліку або пробілу від гравця
	await DialogueManager.next_clicked
	
	# 4. Вимикаємо розмову (ставимо анімацію спокою)
	if sprite != null:
		sprite.play(idle_anim)


func _on_door_body_entered(body: Node2D) -> void:
	# Перевіряємо, чи це зайшов саме наш гравець
	if body.name == "MainHero":
		# Замість "res://scenes/next_scene.tscn" впиши точний шлях до своєї наступної сцени
		Transition.change_scene("res://scene/school/grace_yard_1.tscn")
