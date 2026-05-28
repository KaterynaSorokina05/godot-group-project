extends Node

var floor_1_position = Vector2.ZERO

# Путь, куда Godot будет прятать файл сохранения на твоем компе
var save_path = "user://rust_depo_save.cfg" 

# Функция, которая ЗАПИСЫВАЕТ сохранение
func save_game(current_scene: String):
	print("--- ПОПЫТКА СОХРАНЕНИЯ ---")
	print("Путь сцены, который передали: ", current_scene)
	
	if current_scene == "":
		print("ВНИМАНИЕ: Путь пустой! Сохранять нечего.")
		return

	var config = ConfigFile.new()
	config.set_value("Progress", "last_scene", current_scene)
	
	var error = config.save(save_path)
	if error == OK:
		print("УСПЕХ: Файл физически записан на диск!")
	else:
		print("ОШИБКА: Не удалось записать файл. Код ошибки: ", error)

# Функция, которая ЧИТАЕТ сохранение
func load_game() -> String:
	print("--- ПОПЫТКА ЗАГРУЗКИ ---")
	var config = ConfigFile.new()
	
	if config.load(save_path) == OK:
		var loaded_scene = config.get_value("Progress", "last_scene", "")
		print("УСПЕХ: Прочитали файл с диска. Найдена сцена: ", loaded_scene)
		return loaded_scene
		
	print("ИНФО: Файла сохранения на диске еще нет.")
	return ""
