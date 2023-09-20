extends Node2D

var speed: int = 200
var direction : Vector2 = Vector2.RIGHT
func _process(delta):
	position += speed * delta * direction
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
