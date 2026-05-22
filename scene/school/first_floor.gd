extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMusic.play_music("res://scene/forest/F2.wav")
	$MainHero.set_physics_process(true)
		
		



func play_line(char_name: String, text: String, sprite: AnimatedSprite2D, talk_anim: String, idle_anim: String):
	# 1. Показуємо текст
	DialogueManager.show_text(char_name, text)
	
	# 2. Якщо вказали спрайт - вмикаємо анімацію розмови
	if sprite != null:
		sprite.play(talk_anim)
		
	# 3. Чекаємо кліку або пробілу від гравця
	await DialogueManager.next_clicked
	
	# 4. Вимикаємо розмову (ставимо анімацію спокою)
	if sprite != null:
		sprite.play(idle_anim)


var is_at_door: bool = false
var is_yard:bool = false
func _on_yard_body_exited(body: Node2D) -> void:
		if body.name == "MainHero":
			is_at_door = false
			is_yard = false # Гравець пішов геть, вхід заблоковано


func _on_yard_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.name == "MainHero":
			is_at_door = true
			is_yard = true  # Гравець у зоні, тепер він може увійти



func _on_stairs_body_exited(body: Node2D) -> void:
		if body.name == "MainHero":
			is_at_door = false
			is_yard = false # Гравець пішов геть, вхід заблоковано


func _on_stairs_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
		if body.name == "MainHero":
			is_at_door = true
			is_yard = false  # Гравець у зоні, тепер він може увійти

func _input(event: InputEvent) -> void:
	# Якщо натиснуто Пробіл І гравець зараз стоїть біля дверей
	if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
		if is_at_door and is_yard:
			Transition.change_scene("res://scene/school/grace_yard_1.tscn")
		if is_at_door and not is_yard:
			Transition.change_scene("res://scene/school/second_floor.tscn")
			# Запускаємо плавний перехід
			#Transition.change_scene("res://scene/school/meison_hits.tscn")
			
			
			
