extends AudioStreamPlayer

func _ready():
	# Цей рядок дозволяє музиці грати під час паузи
	process_mode = Node.PROCESS_MODE_ALWAYS
# Ця функція вмикатиме музику
func play_music(music_path: String):
	# Завантажуємо пісню за вказаним шляхом
	var new_music = load(music_path)
	
	# РОЗУМНА ПЕРЕВІРКА: 
	# Якщо ця пісня ВЖЕ стоїть у плеєрі і ВЖЕ грає — ми нічого не робимо!
	if stream == new_music and playing:
		return 
		
	# Якщо це нова пісня — ставимо її і вмикаємо
	stream = new_music
	play()
