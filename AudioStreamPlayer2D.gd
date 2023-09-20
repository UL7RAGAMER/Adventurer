extends AudioStreamPlayer2D
var speed: int = 100
var direction : Vector2 = Vector2.RIGHT
func _process(delta):
	position+=direction * speed * delta


func _on_tree_entered():
	$".".play()
