extends Node2D

func _ready():
	Global.save_game(scene_file_path)
	# 1. Чекаємо рівно 5 секунд після запуску сцени
	await get_tree().create_timer(5.0, false).timeout
	
	# === ГОВОРИТЬ ПЕРС 2 ===
	DialogueManager.show_text("Привіт!")
	$MouthAnimationpers2.visible = true
	$MouthAnimationpers2.play("default")
	
	# ЧЕКАЄМО, ПОКИ ГРАВЕЦЬ НЕ НАТИСНЕ ШЕСТЕРІНКУ!
	await DialogueManager.next_clicked 
	
	$MouthAnimationpers2.stop()
	$MouthAnimationpers2.visible = false
	
	# (Маленьку паузу між фразами можна залишити)
	await get_tree().create_timer(0.5, false).timeout 
	
	# === ГОВОРИТЬ ПЕРС 3 ===
	DialogueManager.show_text("Як у тебе справи?")
	$MouthAnimationpers3.visible = true
	$MouthAnimationpers3.play("default")
	
	# ЗНОВУ ЧЕКАЄМО КЛІКА!
	await DialogueManager.next_clicked
	
	$MouthAnimationpers3.stop()
	$MouthAnimationpers3.visible = false
	
	DialogueManager.hide_text()
