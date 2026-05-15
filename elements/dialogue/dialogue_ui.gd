extends CanvasLayer

signal next_clicked 

var text_speed = 0.05 
var is_typing = false
var current_tween: Tween # Сюди ми будемо зберігати поточну анімацію, щоб мати змогу її зупинити

func _ready():
	visible = false

# Твоя покращена функція з окремим іменем!
func show_text(new_name: String, new_text: String):
	$DialogueBox/TextName.text = new_name
	$DialogueBox/TextLabel.text = new_text
	
	$DialogueBox/TextLabel.visible_ratio = 0.0 
	visible = true
	is_typing = true # Текст почав друкуватися!
	
	# Якщо гравець швидко клікає, стара анімація може ще йти. Вбиваємо її!
	if current_tween:
		current_tween.kill()
		
	current_tween = create_tween()
	var time = new_text.length() * text_speed 
	current_tween.tween_property($DialogueBox/TextLabel, "visible_ratio", 1.0, time)
	
	# Коли анімація закінчується САМА (гравець дочекався), знімаємо прапорець
	current_tween.finished.connect(func(): is_typing = false)

func hide_text():
	visible = false

# Вбудована функція Godot, яка ловить усі натискання
func _input(event):
	# Якщо діалог зараз схований, ігноруємо кліки
	if visible == false:
		return
		
	# Перевіряємо клік мишкою (ліва кнопка) АБО Пробіл / Enter ("ui_accept")
	var is_mouse_click = event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT
	var is_space_pressed = event.is_action_pressed("ui_accept")
	
	if is_mouse_click or is_space_pressed:
		
		if is_typing == true:
			# === ПЕРШИЙ КЛІК: Текст ще друкується ===
			if current_tween:
				current_tween.kill() # Миттєво зупиняємо друк
			$DialogueBox/TextLabel.visible_ratio = 1.0 # Показуємо весь текст
			is_typing = false
			
		else:
			# === ДРУГИЙ КЛІК: Текст вже на екрані ===
			next_clicked.emit() # Кричимо грі "Давай наступну фразу!"
