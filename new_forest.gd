extends Node2D

func _ready():
	
	# 1. Поки екран чорний, забороняємо Браянту ходити
	$MainHero.set_physics_process(false)
	$BonfireAnimation.play("default")
	
	# 2. Чорний екран з підказкою про керування (замість тексту про вагон)
	$CutsceneUI/ColorRect.modulate.a = 1.0
	$CutsceneUI/Label.text = "Використовуйте кнопки A та D для руху"
	$CutsceneUI.visible = true
	
	# Чекаємо 3 секунди
	await get_tree().create_timer(3.0, false).timeout
	$CutsceneUI/Label.text = ""
	
	# 3. Плавна поява лісу (чорний екран зникає)
	var tween_fade_in = create_tween()
	tween_fade_in.tween_property($CutsceneUI/ColorRect, "modulate:a", 0.0, 1.0)
	await tween_fade_in.finished
	
	# 4. ДОЗВОЛЯЄМО Браянту ходити! Гравець бере керування
	$MainHero.set_physics_process(true)


# === СИГНАЛ 1: БРАЯНТ ПІДІЙШОВ ДО МЕТЬЮ ===
func _on_matthew_trigger_body_entered(body: Node2D) -> void:
	# Перевіряємо, чи це саме головний герой зайшов у зону
	if body.name == "MainHero":
		# Вимикаємо цю зону, щоб Метью не повторював фразу нескінченно
		$MatthewTrigger.set_deferred("monitoring", false)
		
		# Зупиняємо гравця на час розмови і ставимо анімацію спокою
		$MainHero.set_physics_process(false)
		$MainHero/AnimatedSprite2D.play("default_right")
		
		# Запускаємо діалог
		DialogueManager.show_text("МЕТЬЮ", "Швидше давай, не майся дурницями.")
		
		# Чекаємо кліку/пробілу
		await DialogueManager.next_clicked
		DialogueManager.hide_text()
		
		# Дозволяємо Браянту йти далі!
		$MainHero.set_physics_process(true)


# === СИГНАЛ 2: БРАЯНТ ПІДІЙШОВ ДО ВАГОНУ ===
func _on_wagon_trigger_body_entered(body: Node2D) -> void:
	if body.name == "MainHero":
		$WagonTrigger.set_deferred("monitoring", false)
		
		# Назавжди зупиняємо гравця (бо далі буде катсцена)
		$MainHero.set_physics_process(false)
		$MainHero/AnimatedSprite2D.play("default_right")
		
		# 1. Робимо чорний екран
		var tween = create_tween()
		tween.tween_property($CutsceneUI/ColorRect, "modulate:a", 1.0, 1.0)
		await tween.finished
		
		# 2. Показуємо діалог поверх темряви
		DialogueManager.show_text("БРАЯНТ", "Так, десь тут має бути.... Що, що це.... Йдіть сюди!")
		await DialogueManager.next_clicked
		DialogueManager.hide_text()
		
		# 3. Переходимо до сцени з трупом! 
		# (Переконайся, що шлях "res://scene/forest/scene_carriage.tscn" правильний для твоєї гри)
		Transition.change_scene("res://scene/forest/scene_carriage.tscn")
