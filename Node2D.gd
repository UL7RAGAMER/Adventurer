extends Node2D

var dmg = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func position():
	var pos1 = $".".position
	var pos2 = $"/root/Level/Player".position
	pos1 = pos2
	return(pos1)
	pass
func dmg_change(dmg1):
	dmg = dmg1
	
	

func _on_level_dmg(dmg):
	print('test')
	
	if dmg == 2:
		dmg = 2
		print(dmg)
	if dmg == 1:
		dmg = 1
		print(dmg)
	pass 
