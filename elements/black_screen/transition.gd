extends CanvasLayer

func change_scene(target_scene: String):
	# 1. Создаем "Твин" (Tween) - это штука для плавной анимации в коде
	var tween = create_tween()
	
	# Плавно меняем прозрачность (modulate:a) нашего ColorRect до 1.0 (непрозрачный) за 0.5 секунд
	tween.tween_property($ColorRect, "modulate:a", 1.0, 0.5)
	
	# Ждём, пока анимация затемнения закончится
	await tween.finished 
	
	# 2. Мгновенно меняем сцену (пока экран полностью черный)
	get_tree().change_scene_to_file(target_scene)
	
	# 3. Снова создаем Твин, чтобы плавно высветлить экран
	var tween_back = create_tween()
	tween_back.tween_property($ColorRect, "modulate:a", 0.0, 0.5)
