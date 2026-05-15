extends CanvasLayer

func change_scene(target_scene: String):
	
	var tween = create_tween()
	
	
	tween.tween_property($ColorRect, "modulate:a", 1.0, 0.5)
	
	
	await tween.finished 
	
	
	get_tree().change_scene_to_file(target_scene)
	
	
	var tween_back = create_tween()
	tween_back.tween_property($ColorRect, "modulate:a", 0.0, 0.5)
