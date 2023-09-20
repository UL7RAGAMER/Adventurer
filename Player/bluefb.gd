extends Area2D
signal atk3()
var speed: int = 100
var direction : Vector2 = Vector2.RIGHT
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=direction * speed * delta
	pass

func test():
	print('sfddf')
	pass
	

func _on_area_entered(area):
	PlayerPos.dmg_change(0.5)
	atk3.emit()
