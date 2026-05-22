extends Node2D

func _ready():
# 1. ЗАБОРОНЯЄМО ГЕРОЮ ХОДИТИ І ДУМАТИ!
    GlobalMusic.play_music("res://scene/forest/F2.wav")
    
    $Sprite2D/MainHero/AnimatedSprite2D.flip_h = false
    $Sprite2D/pers4/AnimatedSprite2D.flip_h = true
    $Sprite2D/pers6/AnimatedSprite2D.flip_h = true
    
    $CutsceneUI/ColorRect.modulate.a = 1.0
    $CutsceneUI/Label.text = "На наступний день"
    $CutsceneUI.visible = true
    
    # Чекаємо 3 секунди
    await get_tree().create_timer(3.0, false).timeout
    $CutsceneUI/Label.text = ""
    
    # 3. Плавна поява лісу (чорний екран зникає)
    var tween_fade_in = create_tween()
    tween_fade_in.tween_property($CutsceneUI/ColorRect, "modulate:a", 0.0, 1.0)
    await tween_fade_in.finished
    
    
    $Sprite2D/MainHero/AnimatedSprite2D.flip_h = false
    $Sprite2D/pers4/AnimatedSprite2D.flip_h = true
    $Sprite2D/pers6/AnimatedSprite2D.flip_h = true
    # Маленька пауза перед початком діалогу, щоб гравець встиг роздивитися сцену
    await get_tree().create_timer(1.0, false).timeout
    
    # === ДІАЛОГ ===
    # Формат: Ім'я, Текст, Вузол Спрайту, Анімація розмови, Анімація спокою
    
    await play_line("БРАЙН", "*пошепки* Ось вона, номер 127. Шафка Ноа. Поліція її вже оглядала, але вони шукали зброю чи наркотики, а не те, що міг сховати сам Ноа.", $Sprite2D/MainHero/AnimatedSprite2D, "talk_right", "default_right")
    
    await play_line("ЛОЛІТА", "Вона заперта на ключ...", $Sprite2D/pers4/AnimatedSprite2D, "talk_left", "default_left")
    
    await play_line("БРАЙН", "Треба знайти щось ,що зможе нам допомогти відкрити його.Треба знайти Грейс ,вона вміє то робити.", $Sprite2D/MainHero/AnimatedSprite2D, "talk_right", "default_right")
    
    $Sprite2D/pers6/AnimatedSprite2D.flip_h = false
    
    await play_line("МЕЙСОН", "Знову ви тут шепочетесь? Я ж казав тобі, інваліде, не плутатися під ногами.", $Sprite2D/pers6/AnimatedSprite2D, "talk_left", "default_left")
    
    $Sprite2D/MainHero/AnimatedSprite2D.flip_h = true
    
    await play_line("БРАЙН", "Ми просто розмовляємо, Мейсоне. Тобі що, немає чим зайнятися? Чи ти нервуєш через Ноа?", $Sprite2D/MainHero/AnimatedSprite2D, "talk_right", "default_right")
    
    await play_line("МЕЙСОН", "Що ти сказав? Ти думаєш, що ти герой?", $Sprite2D/pers6/AnimatedSprite2D, '', '')


    
    DialogueManager.hide_text()
    
    #Transition.change_scene("res://scene/forest/new_forest.tscn")
    # === КІНЕЦЬ СЦЕНИ ===
    # Тут ти можеш завантажити наступний день (наприклад, школу)
    # Transition.change_scene("res://school_first_floor.tscn")
    Transition.change_scene("res://scene/school/meison_hits.tscn")


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
