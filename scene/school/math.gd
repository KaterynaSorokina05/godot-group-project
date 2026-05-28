extends Node2D

# Створюємо прапорець, щоб діалог не запускався по кругу кожен раз, коли ми підходимо
var dialogue_started: bool = false

func _ready() -> void:
	# Тут залишаємо ТІЛЬКИ музику
	GlobalMusic.play_music("res://sountrack/school.wav")


func _on_area_2d_2_body_entered(body: Node2D) -> void:
		# Перевіряємо, чи це саме наш головний герой
	if body.name == "MainHero":
		# 1. Блокуємо рух персонажа під час репліки
		$MainHero.set_physics_process(false)
		
		# 2. Виводимо повідомлення від Брайана (використовуємо твою функцію play_line)
		# Якщо анімація розмови/спокою для цього моменту не потрібна, передаємо стандартні
		await play_line("БРАЙАН", "О, знайшов.", $MainHero/AnimatedSprite2D, "talk_left", "default_left")
		
		# 3. Закриваємо вікно діалогу після натискання Пробілу
		DialogueManager.hide_text()
		
		# 4. Дозволяємо персонажу знову ходити
		$MainHero.set_physics_process(true)
		
		# 5. Скрепка зникає з підлоги назовсім
		# Вузол $Paperclip (або як ти його назвала) повністю видаляється зі сцени
		$Area2D2.queue_free()



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
func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.name == "MainHero":
			is_at_door = false # Гравець пішов геть, вхід заблоковано
			
func _input(event: InputEvent) -> void:
	# Якщо натиснуто Пробіл І гравець зараз стоїть біля дверей
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
		if is_at_door:
			# Запускаємо плавний перехід
			Transition.change_scene("res://scene/school/third_floor.tscn")


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.name == "MainHero":
			is_at_door = true  # Гравець у зоні, тепер він може увійти
