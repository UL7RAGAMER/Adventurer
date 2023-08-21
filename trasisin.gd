extends CanvasLayer


func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.play("new_animation")
	await($AnimationPlayer.animation_finished)
	$AnimationPlayer.play_backwards("new_animation")
	get_tree().change_scene_to_file(target)
	await($AnimationPlayer.animation_finished)
	$".".visible = false
