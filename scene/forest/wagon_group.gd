extends Node2D

func _ready():
# 1. ЗАБОРОНЯЄМО ГЕРОЮ ХОДИТИ І ДУМАТИ!
	GlobalMusic.play_music("res://scene/forest/F2.wav")
	$Group/MainHero.set_physics_process(false)
	
	# Вимикаємо віддзеркалення для Браянта, щоб він дивився вліво (якщо його оригінальний спрайт дивиться вліво)
	$Group/MainHero/AnimatedSprite2D.flip_h = false 
	# Рорі залишаємо як є, якщо йому потрібен flip_h для погляду вправо
	$Group/pers2/AnimatedSprite2D.flip_h = true 
	
	# 3. РОЗВЕРТАЄМО ЇХ ОДНЕ ДО ОДНОГО!
	# Команда зліва (дивляться вправо)
	$Group/pers3/AnimatedSprite2D.play("default_right") # Грейс
	$Group/pers5/AnimatedSprite2D.play("default_right") # Метью
	$Group/pers2/AnimatedSprite2D.play("default_right") # Рорі
	
	# Команда справа (дивляться вліво на Метью та інших)
	$Group/pers4/AnimatedSprite2D.play("default_left")   # Лоліта
	$Group/MainHero/AnimatedSprite2D.play("default_left") # Браянт
	
	# 4. Пауза
	await get_tree().create_timer(1.0, false).timeout
	# === ДІАЛОГ ===
	# Формат: Ім'я, Текст, Вузол Спрайту, Анімація розмови, Анімація спокою
	
	# Лоліта говорить вліво
	await play_line("ЛОЛІТА", "Треба викликати...", $Group/pers4/AnimatedSprite2D, "talk_left", "default_left")
	
	# Метью говорить вправо
	await play_line("МЕТЬЮ", "Ні, подумай спершу. Якщо ми викличемо поліцію, то нас писатимуть, всіх.", $Group/pers5/AnimatedSprite2D, "talk_right", "default_right")
	
	# Лоліта говорить вліво
	await play_line("ЛОЛІТА", "І що?", $Group/pers4/AnimatedSprite2D, "talk_left", "default_left")
	
	# Метью говорить вправо
	await play_line("МЕТЬЮ", "Ти реально не розумієш?", $Group/pers5/AnimatedSprite2D, "talk_right", "default_right")
	
	# Лоліта говорить вліво
	await play_line("ЛОЛІТА", "Метью, я розумію, що там лежить мертва людина...", $Group/pers4/AnimatedSprite2D, "talk_left", "default_left")
	
	# Рорі говорить вправо
	await play_line("РОРІ", "Схоже я його знаю... Він вчився в нашій школі...", $Group/pers2/AnimatedSprite2D, "talk_right", "default_right")
	
	# Браянт говорить вліво
	await play_line("БРАЯНТ", "Я думаю завтра всіх піднімуть на вуха...", $Group/MainHero/AnimatedSprite2D, "talk_left", "default_left")
	DialogueManager.hide_text()
	
	#Transition.change_scene("res://scene/forest/new_forest.tscn")
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
