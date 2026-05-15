extends CharacterBody2D



const SPEED = 120.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")



var is_facing_right = false 



func _physics_process(delta):

	# Гравітація

	if not is_on_floor():

		velocity.y += gravity * delta



	# Отримуємо напрямок руху

	var direction = Input.get_axis("move_left", "move_right")



	# Якщо йдемо ВЛІВО

	if direction < 0:

		velocity.x = -SPEED

		$AnimatedSprite2D.play("left")

		is_facing_right = false

		$AnimatedSprite2D.flip_h = false

		

	# Якщо йдемо ВПРАВО

	elif direction > 0:

		velocity.x = SPEED

		$AnimatedSprite2D.play("right")

		is_facing_right = true

		$AnimatedSprite2D.flip_h = false

		

	# Якщо СТОЇМО на місці

	else:

		velocity.x = move_toward(velocity.x, 0, SPEED)

		

		# Просто граємо анімацію спокою залежно від того, куди дивилися

		if is_facing_right == true:

			$AnimatedSprite2D.play("default_right")

		else:

			$AnimatedSprite2D.play("default_left")



	move_and_slide()
