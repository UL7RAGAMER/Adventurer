extends AnimatedSprite2D
var speed: int = 100
var direction : Vector2 = Vector2.RIGHT
func _process(delta):
	position+=direction * speed * delta


func _on_tree_entered():
	$".".play('new_animation')
	await get_tree().create_timer(6.671).timeout
	$".".play("new_animation_1")
	await animation_finished
	queue_free()
	


