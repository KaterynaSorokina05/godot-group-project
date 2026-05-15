extends CanvasLayer

# Создаем переменную-память. По умолчанию звук включен (true)
var is_sound_on = true
var is_melody_on = true

# 1. ВІДКРИВАЄМО НАЛАШТУВАННЯ 
func _on_settings_button_pressed():
	$MenuOverlay.visible = true
	get_tree().paused = true # ЗУПИНЯЄМО ГРУ!

# 2. ЗАКРИВАЄМО НАЛАШТУВАННЯ (клик по "Закрити")
func _on_close_button_pressed():
	$MenuOverlay.visible = false
	get_tree().paused = false

# 3. ПЕРЕКЛЮЧАТЕЛЬ ЗВУКА
func _on_sound_button_pressed():
	
	is_sound_on = not is_sound_on
	
	
	if is_sound_on == true:
		
		$MenuOverlay/ColorRect/VBoxContainer/SoundButton.texture_normal = load("res://assets/Buttons/Settings/soundON.png")
		AudioServer.set_bus_mute(0, false)
	else:
		
		$MenuOverlay/ColorRect/VBoxContainer/SoundButton.texture_normal = load("res://assets/Buttons/Settings/soundOFF.png")
		AudioServer.set_bus_mute(0, true)


func _on_melody_button_pressed():
	is_melody_on = not is_melody_on
	
	
	if is_melody_on == true:
		
		$MenuOverlay/ColorRect/VBoxContainer/MelodyButton.texture_normal = load("res://assets/Buttons/Settings/melodyON.png")
		AudioServer.set_bus_mute(0, false)
	else:
		
		$MenuOverlay/ColorRect/VBoxContainer/MelodyButton.texture_normal = load("res://assets/Buttons/Settings/melodyOFF.png")
		AudioServer.set_bus_mute(0, true)


func _on_menu_button_pressed() -> void:
	# 1. Обов'язково знімаємо гру з паузи!
	get_tree().paused = false
	
	# 2. Ховаємо саму темну панель налаштувань (щоб вона не залишилася висіти поверх Головного меню)
	$MenuOverlay.visible = false
	
# 3. Переходимо в сцену Головного меню (через твою шторку) 
# УВАГА: перевір, чи правильний шлях до main_scene.tscn! 
# Якщо він інший, натисніть на сцені меню правою кнопкою -> "Копіювати шлях" і встав сюди:
	Transition.change_scene("res://main_scene.tscn")
