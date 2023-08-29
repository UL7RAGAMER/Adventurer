extends CanvasLayer
var once = 1

func change_scene_to_file(target: String) -> void:
	while once == 1:
		$AudioStreamPlayer.play()
		once = 2
		$AnimationPlayer.play("new_animation")
	await($AnimationPlayer.animation_finished)
	$AnimationPlayer.play_backwards("new_animation")
	get_tree().change_scene_to_file(target)
	await($AnimationPlayer.animation_finished)
	$".".visible = false
func playani():
	print('sfd')
	$".".visible = true
	$AnimationPlayer.play("new_animation")

func r_playani():
	print('sfd')
	$".".visible = true
	$AnimationPlayer.play_backwards("new_animation")

