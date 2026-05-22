extends Node2D

func _ready():
	
# 1. ЗАБОРОНЯЄМО ГЕРОЮ ХОДИТИ І ДУМАТИ!
	GlobalMusic.play_music("res://scene/forest/F2.wav")
	$Sprite2D/MainHero.set_physics_process(false)

	# Маленька пауза перед початком діалогу, щоб гравець встиг роздивитися сцену
	await get_tree().create_timer(1.0, false).timeout
	
	# === ДІАЛОГ ===
	# Формат: Ім'я, Текст, Вузол Спрайту, Анімація розмови, Анімація спокою
	
	await play_line("БРАЙАН", "Грейс,треба твоя допомога.", $Sprite2D/MainHero/AnimatedSprite2D, "talk_left", "default_left")
	
	await play_line("ГРЕЙС", "Брайане ,що з твоїм обличчям?", $Sprite2D/pers3/AnimatedSprite2D, "talk_right", "default_right")
	
	await play_line("БРАЙАН", "Потім розкажу ,нам треба твоя навичка взлому дверей.", $Sprite2D/MainHero/AnimatedSprite2D, "talk_left", "default_left")
	
	await play_line("ГРЕЙС", "Тобі треба знайти якусь шпильку або щось схоже ,щоб я відкрила двері . Побачимось вже на місці.", $Sprite2D/pers3/AnimatedSprite2D, "talk_right", "default_right")
	   
	DialogueManager.hide_text()
	
	#Transition.change_scene("res://scene/forest/new_forest.tscn")
	# === КІНЕЦЬ СЦЕНИ ===
	# Тут ти можеш завантажити наступний день (наприклад, школу)
	# Transition.change_scene("res://school_first_floor.tscn")
	$Sprite2D/MainHero.set_physics_process(true)


	
	
	
	
	
	

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



var is_at_door: bool = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "MainHero":
		is_at_door = true  # Гравець у зоні, тепер він може увійти


func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.name == "MainHero":
		is_at_door = false # Гравець пішов геть, вхід заблоковано
		
func _input(event: InputEvent) -> void:
	# Якщо натиснуто Пробіл І гравець зараз стоїть біля дверей
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
		if is_at_door:
			# Запускаємо плавний перехід
			Transition.change_scene("res://scene/school/first_floor.tscn")
