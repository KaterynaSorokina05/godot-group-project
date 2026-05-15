extends CanvasLayer

# Создаем переменную-память. По умолчанию звук включен (true)
var is_sound_on = true
var is_melody_on = true

func _ready():
	# При завантаженні меню має бути приховане
	$MenuOverlay.visible = false
	# Гра НЕ має бути на паузі
	get_tree().paused = false
# 1. ВІДКРИВАЄМО НАЛАШТУВАННЯ 
func _on_settings_button_pressed():
	$MenuOverlay.visible = true
	get_tree().paused = true # Это останавливает игру, но не GlobalMusic, если у него режим Always
	

# 2. ЗАКРИВАЄМО НАЛАШТУВАННЯ (клик по "Закрити")
func _on_close_button_pressed():
	$MenuOverlay.visible = false
	get_tree().paused = false

# 3. ПЕРЕКЛЮЧАТЕЛЬ ЗВУКОВ (Эффекты)
func _on_sound_button_pressed():
	is_sound_on = not is_sound_on
	
	# Ищем канал "Sound"
	var sound_bus = AudioServer.get_bus_index("Sound")
	
	if is_sound_on == true:
		$MenuOverlay/ColorRect/VBoxContainer/SoundButton.texture_normal = load("res://assets/Buttons/Settings/soundON.png")
		AudioServer.set_bus_mute(sound_bus, false) # Включаем звук
	else:
		$MenuOverlay/ColorRect/VBoxContainer/SoundButton.texture_normal = load("res://assets/Buttons/Settings/soundOFF.png")
		AudioServer.set_bus_mute(sound_bus, true)  # Выключаем звук


# 4. ПЕРЕКЛЮЧАТЕЛЬ МЕЛОДИИ (Музыка)
func _on_melody_button_pressed():
	is_melody_on = not is_melody_on
	
	# Ищем канал "Music"
	var music_bus = AudioServer.get_bus_index("Music")
	
	if is_melody_on == true:
		$MenuOverlay/ColorRect/VBoxContainer/MelodyButton.texture_normal = load("res://assets/Buttons/Settings/melodyON.png")
		AudioServer.set_bus_mute(music_bus, false) # Включаем музыку
	else:
		$MenuOverlay/ColorRect/VBoxContainer/MelodyButton.texture_normal = load("res://assets/Buttons/Settings/melodyOFF.png")
		AudioServer.set_bus_mute(music_bus, true)  # Выключаем музыку


# 5. КНОПКА ВОЗВРАТА В ГЛАВНОЕ МЕНЮ
func _on_menu_button_pressed() -> void:
	# 1. Обов'язково знімаємо гру з паузи!
	get_tree().paused = false
	
	# 2. Ховаємо саму темну панель налаштувань (щоб вона не залишилася висіти поверх Головного меню)
	$MenuOverlay.visible = false
	
	# 3. Переходимо в сцену Головного меню (через твою шторку) 
	Transition.change_scene("res://main_scene.tscn")
