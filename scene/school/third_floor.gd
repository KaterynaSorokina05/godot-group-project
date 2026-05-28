extends Node2D
# Створюємо прапорець, щоб діалог не запускався по кругу кожен раз, коли ми підходимо
var dialogue_started: bool = false

func _ready() -> void:
    # Тут залишаємо ТІЛЬКИ музику
    GlobalMusic.play_music("res://sountrack/school.wav")
    $pers2/AnimatedSprite2D.flip_h = true
    $pers4/AnimatedSprite2D.flip_h = false


# Called when the node enters the scene tree for the first time.
func _on_talk_body_entered(body: Node2D) -> void:
    # Перевіряємо: це зайшов саме наш герой І діалог ще не починався?
    if body.name == "MainHero" and not dialogue_started:
        dialogue_started = true # Блокуємо повторний старт
        $pers4/AnimatedSprite2D.flip_h = true
        
        # Забороняємо герою ходити, поки вони говорять
        $Sprite2D/MainHero.set_physics_process(false)
        
        #
        #Рорі:Йоу,чувак що з обличчям ?
#Лоліта:його вдарив Мейсон 
#Рорі:Він забув як чисте обличчя виглядає?Побачу ,приб'ю придурка.Ти як?
#Брайан:все добре.Я зараз шукаю щось,чим Грейс зможе відкрити шафку.Якщо що зустрічаємося біля шафки Ноа.
#Лоліта:добре,ми прийдемо 
        # НАШ ДІАЛОГ (перенесений з _ready)
        $pers4/AnimatedSprite2D.flip_h = false
        $pers2/AnimatedSprite2D.flip_h = false
        await play_line("РОРІ", "Йоу,чувак що з обличчям ?",$pers2/AnimatedSprite2D, "talk_right", "default_right")
        
        await play_line("ЛОЛІТА", "його вдарив Мейсон", $pers4/AnimatedSprite2D, "talk_right", "default_right")
        
        await play_line("РОРІ", "Він забув як чисте обличчя виглядає?Побачу ,приб'ю придурка.Ти як?",$pers2/AnimatedSprite2D, "talk_right", "default_right")
        
        await play_line("БРАЙАН", "все добре. Ми з Грейс збираємося відкрити шафку Ноа. Побачимося там?",$Sprite2D/MainHero/AnimatedSprite2D, "talk_left", "default_left")

        await play_line("ЛОЛІТА", "добре,ми прийдемо ", $pers4/AnimatedSprite2D, "talk_right", "default_right")
        
        # ПІСЛЯ ДІАЛОГУ: ховаємо вікно і дозволяємо Брайану знову ходити
        DialogueManager.hide_text()
        $Sprite2D/MainHero.set_physics_process(true)
# ==========================================
# ПОКРАЩЕНА ФУНКЦІЯ ДЛЯ АНІМАЦІЇ ПЕРСОНАЖІВ
# ==========================================
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
var is_math:bool = false
func _on_stairs_body_exited(body: Node2D) -> void:
    if body.name == "MainHero":
        is_at_door = false
        is_math = false # Гравець пішов геть, вхід заблоковано


func _on_stairs_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
    if body.name == "MainHero":
        is_at_door = true
        is_math = false # Гравець у зоні, тепер він може увійти


func _on_math_body_exited(body: Node2D) -> void:
    if body.name == "MainHero":
        is_at_door = false
        is_math = false# Гравець пішов геть, вхід заблоковано


func _on_math_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
    if body.name == "MainHero":
        is_math = true
        is_at_door = true
func _input(event: InputEvent) -> void:
    # Якщо натиснуто Пробіл І гравець зараз стоїть біля дверей
    if event.is_action_pressed("ui_accept") or (event is InputEventKey and event.keycode == KEY_SPACE):
        if is_at_door and not is_math:
            Transition.change_scene("res://scene/school/breaking_locket.tscn")
        if is_at_door and is_math:
            Transition.change_scene("res://scene/school/math.tscn")
            # Запускаємо плавний перехід
            #Transition.change_scene("res://scene/school/meison_hits.tscn")
