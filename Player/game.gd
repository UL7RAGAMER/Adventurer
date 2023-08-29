extends Control


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_restart_pressed():
	Trasisin.r_playani()
	get_tree().change_scene_to_file('res://Level/level.tscn')
	pass


func _on_quit_pressed():
	get_tree().quit()
	pass 
