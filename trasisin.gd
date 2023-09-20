extends CanvasLayer
var once = 1

func change_scene_to_file(target: String) -> void:
	await get_tree().create_timer(0.1).timeout
	Trasisin.visible = true
	while once == 1:
		$AudioStreamPlayer.play()
		once = 2
		$AnimationPlayer.play("new_animation")
	await get_tree().create_timer(1.1).timeout
	$AnimationPlayer.play_backwards("new_animation")
	get_tree().change_scene_to_file(target)
	await get_tree().create_timer(1.1).timeout
	$".".visible = false
func playani():
	print('sfd')
	$".".visible = true
	$AnimationPlayer.play("new_animation")

func r_playani():
	print('sfd')
	$".".visible = true
	$AnimationPlayer.play_backwards("new_animation")

