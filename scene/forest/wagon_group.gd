extends Node2D

func _ready():
	$Group/MainHero/AnimatedSprite2D.flip_h = true
	$Group/pers2/AnimatedSprite2D.flip_h = true
	# Маленька пауза перед початком діалогу, щоб гравець встиг роздивитися сцену
	await get_tree().create_timer(1.0, false).timeout
	
	# === ДІАЛОГ ===
	# Формат: Ім'я, Текст, Вузол Спрайту, Анімація розмови, Анімація спокою
	
	await play_line("ЛОЛІТА", "Треба викликати...", $Group/pers4/AnimatedSprite2D, "talk_right", "default_right")
	
	await play_line("МЕТЬЮ", "Ні, подумай спершу. Якщо ми викличемо поліцію, то нас писатимуть, всіх.", $Group/pers5/AnimatedSprite2D, "talk_right", "default_right")
	
	await play_line("ЛОЛІТА", "І що?", $Group/pers4/AnimatedSprite2D, "talk_right", "default_right")
	
	await play_line("МЕТЬЮ", "Ти реально не розумієш?", $Group/pers5/AnimatedSprite2D, "talk_right", "default_right")
	
	await play_line("ЛОЛІТА", "Метью, я розумію, що там лежить мертва людина...", $Group/pers4/AnimatedSprite2D, "talk_right", "default_right")
	
	# Анімації Рорі (перевір, куди він дивиться)
	await play_line("РОРІ", "Схоже я його знаю... Він вчився в нашій школі...", $Group/pers2/AnimatedSprite2D, "talk_right", "default_right")
	
	await play_line("БРАЯНТ", "Я думаю завтра всіх піднімуть на вуха...", $Group/MainHero/AnimatedSprite2D, "talk_right", "default_right")
	
	DialogueManager.hide_text()
	
	# === КІНЕЦЬ СЦЕНИ ===
	# Тут ти можеш завантажити наступний день (наприклад, школу)
	# Transition.change_scene("res://school_first_floor.tscn")


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
