extends Node

var floor_1_position = Vector2.ZERO

# Путь, куда Godot будет прятать файл сохранения на твоем компе
var save_path = "user://rust_depo_save.cfg" 

# Функция, которая ЗАПИСЫВАЕТ сохранение
func save_game(current_scene: String):
	var config = ConfigFile.new()
	# Записываем в секцию "Progress" параметр "last_scene"
	config.set_value("Progress", "last_scene", current_scene)
	config.save(save_path)

# Функция, которая ЧИТАЕТ сохранение
func load_game() -> String:
	var config = ConfigFile.new()
	# Если файл успешно загрузился:
	if config.load(save_path) == OK:
		# Возвращаем путь к сцене
		return config.get_value("Progress", "last_scene", "")
	
	# Если файла нет (игрок зашел первый раз)
	return ""
