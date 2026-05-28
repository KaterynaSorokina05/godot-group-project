extends Node2D

# Створюємо прапорець, щоб діалог не запускався по кругу кожен раз, коли ми підходимо
var dialogue_started: bool = false

func _ready() -> void:
	# Тут залишаємо ТІЛЬКИ музику
	GlobalMusic.play_music("res://sountrack/school.wav")


# Ця функція у тебе вже створена внизу скрипта (Godot її підключив від синьої зони)
func _on_talk_body_entered(body: Node2D) -> void:
	# Перевіряємо: це зайшов саме наш герой І діалог ще не починався?
	if body.name == "MainHero" and not dialogue_started:
		dialogue_started = true # Блокуємо повторний старт
		
		# === ЖОРСТКА ЗУПИНКА ГЕРОЯ ===
		# 1. Скидаємо швидкість в 0, щоб він не котився по інерції
		$Sprite2D/MainHero.velocity = Vector2.ZERO
		
		# 2. Примусово вмикаємо анімацію спокою, щоб він не біг на місці
		if $Sprite2D/MainHero/AnimatedSprite2D.flip_h:
			$Sprite2D/MainHero/AnimatedSprite2D.play("default_left")
		else:
			$Sprite2D/MainHero/AnimatedSprite2D.play("default_right")
		
		# 3. І тільки тепер повністю вимикаємо фізичний процес
		$Sprite2D/MainHero.set_physics_process(false)
		
		# НАШ ДІАЛОГ
		await play_line("МЕТЬЮ", "Привіт! Я тут намагаюсь знайти якусь інформацію про...", null, "", "")
		
		await play_line("БРАЙАН", "Зустрічаємося біля шафки Ноа.", $Sprite2D/MainHero/AnimatedSprite2D, "talk_right", "default_right")
		
		await play_line("МЕТЬЮ", "Домовились", null, "", "")
		
		# ПІСЛЯ ДІАЛОГУ: ховаємо вікно і дозволяємо Брайану знову ходити
		DialogueManager.hide_text()
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


func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.name == "MainHero":
			is_at_door = false # Гравець пішов геть, вхід заблоковано
			
func _input(event: InputEvent) -> void:
	# Якщо натиснуто Пробіл І гравець зараз стоїть біля дверей
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
		if is_at_door:
			# Запускаємо плавний перехід
			Transition.change_scene("res://scene/school/second_floor.tscn")
