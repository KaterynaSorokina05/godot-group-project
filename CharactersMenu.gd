extends Control

# Создаем список (массив) путей ко всем картинкам персонажей
var images = [
	"res://Images/characters/Rory_Li.png",    # 0: Рори
	"res://Images/characters/Lolita_Murphy.png",  # 1: Лолита
	"res://Images/characters/Grace_Adams.png",   # 2: Грейс
	"res://Images/characters/Bryant_Hubert.png",  # 3: Браянт
	"res://Images/characters/Matthew_Henderson.png"  # 4: Меттью
]

# Переменная, которая помнит, на какой картинке мы сейчас находимся
var current_index = 0

func _ready():
	GlobalMusic.play_music("res://intro.wav")
	# При запуске сцены сразу показываем первую картинку (под номером 0)
	show_character(current_index)

# Функция, которая обновляет картинку на экране
func show_character(index):
	$ProfileImage.texture = load(images[index])

# === КНОПКА ВПЕРЕД ===
func _on_right_button_pressed():
	current_index += 1
	# Если мы дошли до конца списка, возвращаемся к первому (зацикливаем)
	if current_index >= images.size():
		current_index = 0
	
	show_character(current_index)

# === КНОПКА НАЗАД ===
func _on_left_button_pressed():
	current_index -= 1
	# Если мы листаем назад от первого, перекидываем в самый конец
	if current_index < 0:
		current_index = images.size() - 1
		
	show_character(current_index)

# === КНОПКА ВЫХОДА В МЕНЮ ===
func _on_back_menu_pressed():
	# Возвращаемся в главное меню (проверь путь к своей сцене меню!)
	Transition.change_scene("res://main_scene.tscn")
