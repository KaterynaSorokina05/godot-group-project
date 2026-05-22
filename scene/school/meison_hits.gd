extends Node2D

func _ready():
# 1. ЗАБОРОНЯЄМО ГЕРОЮ ХОДИТИ І ДУМАТИ!
	# Маленька пауза перед початком діалогу, щоб гравець встиг роздивитися сцену
	GlobalMusic.play_music("res://sountrack/hit.mp3")
	await get_tree().create_timer(1.0, false).timeout
	
	# === ДІАЛОГ ===
	# Формат: Ім'я, Текст, Вузол Спрайту, Анімація розмови, Анімація спокою
	
	await play_line("МЕЙСОН", "Ще раз почую це ім’я від тебе — і ти ляжеш поруч із ним у тому вагоні. Зрозумів?", null, "", "")
	

	
	DialogueManager.hide_text()
	
	#Transition.change_scene("res://scene/forest/new_forest.tscn")
	# === КІНЕЦЬ СЦЕНИ ===
	# Тут ти можеш завантажити наступний день (наприклад, школу)
	# Transition.change_scene("res://school_first_floor.tscn")
	Transition.change_scene("res://scene/school/lolita_helps.tscn")


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
