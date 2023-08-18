extends Area2D
var speed: int = 200
var direction : Vector2 = Vector2.RIGHT
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=direction * speed * delta
	pass
