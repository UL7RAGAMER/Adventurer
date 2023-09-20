extends CharacterBody2D
var ani_lock = false
@onready var player = $"../../Player"
var bullet = preload("res://Level/wasp_bullet.tscn")
var num = 1
func _process(delta):
	idle()

	
	var pos = ($".".global_position - player.global_position)

	if pos.x >0:
		$AnimatedSprite2D.flip_h = false
	elif pos.x <0:
		$AnimatedSprite2D.flip_h = true
	if pos <= Vector2(150,-70) and pos >= Vector2(-150,70):
		if num == 1:
			ani_lock = true
			atk()

func idle():

	if ani_lock == false:
		$AnimatedSprite2D.play("idle")
func atk():
	$AnimatedSprite2D.play("atk")
	await $AnimatedSprite2D.animation_finished
	var bul = bullet.instantiate() as Node2D
	var direc = ($"/root/Level/Player/Marker2D".global_position - $".".global_position).normalized()
	print($Marker2D.global_position, $".".position,get_global_mouse_position())
	bul.direction = direc
	bul.rotation_degrees = rad_to_deg(direc.angle())
	bul.position =  $".".position
	print(bul.position)
	num+=1
	$"..".add_child(bul)
	ani_lock = false




func _on_timer_timeout():
	num = 1
	pass # Replace with function body.
