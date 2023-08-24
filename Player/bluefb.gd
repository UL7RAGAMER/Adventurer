extends Area2D
signal atk3()
var speed: int = 400
var direction : Vector2 = Vector2.RIGHT
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=direction * speed * delta
	pass



func _on_area_entered(area):
	atk3.emit()
