extends CharacterBody2D
var anilocked :bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var t = 0.01
var dmg = false
var run  = false
var direction : Vector2 = Vector2.ZERO
var health = 15
var xp = 100
signal player_hurt1()
func _physics_process(delta):
	t = randf_range(0,0.03)
	if PlayerPos.dead == true:
		t = 0
	if health  <= 0:
		$".".queue_free()
		var c = get_node('/root/Level/Player')
		c.gain_xp(150)
	var pos = $"../Player".position.x - $".".position.x
	if anilocked == false:
		$boar.play("idle")
	if not is_on_floor():
		velocity.y += (gravity) * delta 
	if (pos < 200 and pos > 0) or (pos > -200 and pos < 0) :

		run = true
		var direc = ($"../Player".global_position.x - $".".global_position.x )
		if direc <0:
			position.x -= randi_range(80,100) * delta
			
		else:
			position.x += randi_range(80,100) * delta
#		$".".global_position =  $".".global_position.lerp($"../Player".global_position, t)
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
	if (pos <= 65 and pos > 0) or (pos >= -49 and pos < 0) :
		player_hurt1.emit()
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




