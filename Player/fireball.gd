extends Area2D
signal atk2()
var speed: int = 200
var direction : Vector2 = Vector2.RIGHT
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=direction * speed * delta
	pass


func _on_area_entered(area):
	atk2.emit()
	pass # Replace with function body.
