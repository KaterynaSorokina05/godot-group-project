extends CanvasLayer
# 1. ОГОЛОШУЄМО СВІЙ СИГНАЛ у самому верху:
signal next_clicked
# Додаємо змінну швидкості (0.05 секунд на одну букву – це класична швидкість)
var text_speed = 0.05
func _ready():
	# При запуску гри вікно діалогу завжди сховано
	visible = false

# Функція, щоб показати потрібний текст
func show_text(new_text: String):
	$DialogueBox/TextLabel.text = new_text
	
	# 1. ОБНУЛЮЄМО ВИДИМІСТЬ (ховаємо всі літери перед початком)
	$DialogueBox/TextLabel.visible_ratio = 0.0 
	visible = true
	
	# 2. ВИКЛИКАЄМО МАГІЮ АНІМАЦІЇ (Tween)
	var tween = create_tween()
	
	# 3. ВИСЧИВАЕМ ЧАС (щоб довгий текст друкувався довше, ніж короткий)
	var time = new_text.length() * text_speed 
	
	# 4. ЗАПУСКАЄМО ДРУК: плавно змінюємо visible_ratio до 1.0 за вирахований час
	tween.tween_property($DialogueBox/TextLabel, "visible_ratio", 1.0, time)

# Функція, щоб сховати діалог
func hide_text():
	visible = false


func _on_next_button_pressed() -> void:
	# Випускаємо сигнал (кричимо на всю гру, що кнопка натиснута)
	next_clicked.emit()
