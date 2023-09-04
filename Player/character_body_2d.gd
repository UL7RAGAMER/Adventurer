extends CharacterBody2D
var anilocked :bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var t = 0.02
var dmg = false
var run  = false
var direction : Vector2 = Vector2.ZERO
var health = 5
signal player_hurt()
func _physics_process(delta):
	t = randf_range(0,0.03)
	if PlayerPos.dead == true:
		t = 0
	if health  <= 0:
		$".".queue_free()
		var c = get_node('/root/Level/Player')
		c.gain_xp(50)
	var pos = $"../Player".position.x - $".".position.x
	if anilocked == false:
		$boar.play("idle")
	if not is_on_floor():
		velocity.y += (gravity) * delta 
	if (pos < 150 and pos > 0) or (pos > -150 and pos < 0) :

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
#	_on_player_fb_dmg()
#	_on_player_bfb_dmg()
	hurt()
	move_and_slide()
	

func hurt():
	var x = false
	var pos = $"../Player".position.x - $".".position.x
	if (pos <= 28 and pos > 0) or (pos >= -30 and pos < 0) :
		player_hurt.emit()
		x = true
	return(x)	
		
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
	await get_tree().create_timer(0.1).timeout	
	health -= PlayerPos.dmg
	$Timer.start()
	anilocked = true
	dmg = true
	$boar.play("hurt")
	pass




func _on_player_posi(position):
	pass




func _on_level_dmg(dmg) -> void:
	pass # Replace with function body.




