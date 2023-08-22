extends CharacterBody2D
var anilocked :bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var t = 0.03
var dmg = false
var run  = false
var direction : Vector2 = Vector2.ZERO
var health = 2
signal player_hurt()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if health  == 0:
		$".".queue_free()
	var pos = $"../Player".position.x - $".".position.x
	if anilocked == false:
		$boar.play("idle")
	if not is_on_floor():
		velocity.y += (gravity) * delta
	if (pos < 100 and pos > 0) or (pos > -100 and pos < 0) :
		run = true
		$".".global_position =  $".".global_position.lerp($"../Player".global_position, t)
		anilocked = true
		if dmg == false:
			$boar.play("run")
		if dmg==true:
			$boar.play("run_hurt")
			pass
			
	else:
		run = false	

		pass
	if pos > 0:
		$boar.flip_h = true 
	elif pos < 0:
		$boar.flip_h = false
	hurt()
	move_and_slide()
	

func hurt():
	var pos = $"../Player".position.x - $".".position.x
	if (pos <= 28 and pos > 0) or (pos >= -30 and pos < 0) :
		player_hurt.emit()
func _on_boar_animation_finished():
	if $boar.animation == 'hurt':
		anilocked = false
	if $boar.animation == 'run':
		anilocked = false
	pass

func _on_timer_timeout():
	dmg = false
	pass



func _on_area_2d_area_entered(area):
	health -= 1
	if run == true:
		print('working2')
	$Timer.start()
	anilocked = true
	dmg = true
	$boar.play("hurt")
	print('hurt')
	pass


func _on_player_dead():
	queue_free()
	

func _on_player_posi(position):
	pass

