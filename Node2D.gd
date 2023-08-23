extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func position():
	var pos1 = $".".position
	var pos2 = $"/root/Level/Player".position
	pos1 = pos2
	return(pos1)
	pass
