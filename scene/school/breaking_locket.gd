extends Node2D

# Створюємо прапорець, щоб діалог не запускався по кругу кожен раз, коли ми підходимо
var dialogue_started: bool = false

func _ready() -> void:
	# Тут залишаємо ТІЛЬКИ музику
	GlobalMusic.play_music("res://scene/forest/F2.wav")


# Ця функція у тебе вже створена внизу скрипта (Godot її підключив від синьої зони)
func _on_talk_body_entered(body: Node2D) -> void:
	# Перевіряємо: це зайшов саме наш герой І діалог ще не починався?
	if body.name == "MainHero" and not dialogue_started:
		dialogue_started = true # Блокуємо повторний старт
		
		# Забороняємо герою ходити, поки вони говорять
		$MainHero.set_physics_process(false)
		
		# НАШ ДІАЛОГ (перенесений з _ready)
		await play_line("ГРЕЙС", "так ,спробуємо", $pers3/AnimatedSprite2D, "talk_right", "default_right")
		
		await play_line("ГРЕЙС", "Є! Відкрила. Так... підручники, кросівки... О! Дивіться, на внутрішній стороні дверцят.", $pers3/AnimatedSprite2D, "talk_right", "default_right")
		
		await play_line("ГРЕЙС", "Тут щось написано... дуже дрібним почерком. «Залізна гусениця заснула навічно в бетонному коконі. Шукай у череві останнього звіра. Код число звіра». Що це взагалі означає?", $pers3/AnimatedSprite2D, "talk_right", "default_right")

		await play_line("РОРІ", "Це ж старе закинуте депо на околиці. «Бетонний кокон» — це головний ангар, а «залізна гусениця» — потяг.", $pers2/AnimatedSprite2D, "talk_left", "default_left")
		
		await play_line("БРАЙАН", "А число звіра ,скоріше за все вказує на номер складу .666...", $MaimHero/AnimatedSprite2D, "talk_left", "default_left")
		
		# Меттью (вправо, персонаж 5)
		await play_line("МЕТЬЮ", "Я, до речі, дещо знайшов. І це дуже дивно.", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Брайан (вправо, MainHero)
		await play_line("БРАЙАН", "Що саме?", $MainHero/AnimatedSprite2D, "talk_right", "default_right")

		# Меттью (вправо)
		await play_line("МЕТЬЮ", "Я заліз у старі шкільні файли Ноа. Особова справа майже порожня, але там були нотатки від психолога і кілька сканів документів. Його сім’я… была дуже релігійною.", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Лоліта (вліво)
		await play_line("ЛОЛІТА", "Наскільки «дуже»?", $pers4/AnimatedSprite2D, "talk_left", "default_left")

		# Меттью (вправо)
		await play_line("МЕТЬЮ", "Типу… фанатично. Його батько був проповідником у якійсь маленькій громаді за містом. У документах постійно згадується «очищення від гріха», «знаки диявола» і всяке таке.", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Рорі (вліво)
		await play_line("РОРІ", "Супер. Ще скажи, що вони приносили кіз у жертву.", $pers2/AnimatedSprite2D, "talk_left", "default_left")

		# Меттью (вправо)
		await play_line("МЕТЬЮ", "Не смішно. Послухайте далі. Тут є запис від шкільного психолога. Ноа кілька разів говорив про «число звіра». Казав, що його батько повторював йому: «Той, хто зрозуміє число, побачить справжнє обличчя чудовиська».", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Грейс (вправо)
		await play_line("ГРЕЙС", "666…", $pers3/AnimatedSprite2D, "talk_right", "default_right")

		# Меттью (вправо)
		await play_line("МЕТЬЮ", "Так. Це з Біблії. Книга Об’явлення. Там 666 називають числом звіра або знаком антихриста.", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Лоліта (вліво)
		await play_line("ЛОЛІТА", "І ти думаєш, Ноа залишив це як підказку?", $pers4/AnimatedSprite2D, "talk_left", "default_left")

		# Меттью (вправо)
		await play_line("МЕТЬЮ", "Можливо. Але є ще дещо. Я знайшов старий план депо в міському архіві. Після пожежі більшість ангарів і колій просто законсервували… але один сектор повністю закрили бетонною стіною. У документах він проходить як технічний блок №6-6-6.", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Рорі (вліво)
		await play_line("РОРІ", "Сектор шість-шість-шість? Та ви знущаєтесь.", $pers2/AnimatedSprite2D, "talk_left", "default_left")

		# Меттью (вправо)
		await play_line("МЕТЬЮ", "Я серйозно. І знаєте, що найгірше? У плані він позначений прямо під головним ангаром. Наче там є якийсь підземний рівень або старий сервісний тунель.", $pers5/AnimatedSprite2D, "talk_right", "default_right")

		# Грейс (вправо)
		await play_line("ГРЕЙС", "«Бетонний кокон»…", $pers3/AnimatedSprite2D, "talk_right", "default_right")

		# Брайан (вправо, MainHero)
		await play_line("БРАЙАН", "А «черево останнього звіра» може бути не вагоном. Може, це останній сектор депо.", $MainHero/AnimatedSprite2D, "talk_right", "default_right")

		# Лоліта (вліво)
		await play_line("ЛОЛІТА", "Тоді Ноа сховав щось у закритій частині комплексу.", $pers4/AnimatedSprite2D, "talk_left", "default_left")

		# Рорі (вліво)
		await play_line("РОРІ", "Чудово. Закинуте депо, підземний тунель і число звіра. Обожнюю наше життя.", $pers2/AnimatedSprite2D, "talk_left", "default_left")

		# Брайан (вправо, MainHero)
		await play_line("БРАЙАН", "Мейсон явно знає більше, ніж говорить. Ми їдемо туди сьогодні ввечері.", $MainHero/AnimatedSprite2D, "talk_right", "default_right")

		# ЗАКРИВАЄМО ВІКНО ДІАЛОГУ
		DialogueManager.hide_text()
		Transition.change_scene("res://scene/school/last_scene.tscn")
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
