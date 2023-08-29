extends CharacterBody2D
signal posi(position)
signal fireball(position,direction )
signal bluefb(position, direction)
signal atk()
signal dead()
const SPEED = 200.0
const JUMP_VELOCITY = -220.0
var max_health = PlayerPos.def
var health = max_health 
var hit = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var ani_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var can_attacked : bool = true
var can_fb : bool = true
var can_bfb : bool = true

var can_move = true
var fb_cost = 40
var bfb_cost = 20
var mana = PlayerPos.mana
func _physics_process(delta):
	max_health = PlayerPos.def

	$"../CanvasLayer/TextureProgressBar2".set_max(PlayerPos.max_mana)
	$"../CanvasLayer/TextureProgressBar".set_max(max_health)
	up_health()
	if health <= 0:
		health = 0
		$player.play("dead")

		await $player.animation_finished
		$player.set_frame(7)
		$"../CanvasLayer/AnimationTree".play("new_animation")
		await $"../CanvasLayer/AnimationTree".animation_finished
		$"../CanvasLayer/AnimationTree".play("new_animation")		
		$"../CanvasLayer".visible = false
		$".".visible = false
		Trasisin.visible = true
		Trasisin.change_scene_to_file("res://Player/game.tscn")

	if not is_on_floor():
		velocity.y += (gravity) * delta
		was_in_air = true
	else:
		
		if was_in_air == true:
			land()	
		was_in_air = false
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
	
	if Input.is_action_just_pressed("hurt"):
		health-=1
	if health != 0 and (not health<0):	
		direction = Input.get_vector("Left", "Right", "None", 'None')
		if direction and can_move:
			velocity.x = direction.x * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if Input.is_action_pressed("Right"):
			get_node("attack").set_scale(Vector2(1, 1))
		elif Input.is_action_pressed("Left"): 
			get_node("attack").set_scale(Vector2(-1, 1))
			
	if Input.is_action_just_pressed("fireball") and can_fb:
		if mana > fb_cost:		
			can_fb = false
			var fb_markers  = $Fireball_pos.get_children()
			var selected_marker = fb_markers[randi() % fb_markers.size()]
			var direc_fb = (get_global_mouse_position() - position).normalized()
			print('fireball')
			mana -= fb_cost
			$Fireball_cd.start()
			fireball.emit(selected_marker.global_position, direc_fb)

	if Input.is_action_just_pressed("bluefb") and can_bfb:
		if mana > bfb_cost:
			can_bfb = false
			var  bfb_marker = $Fireball_pos2.get_children()
			var selected_marker = bfb_marker[randi() % bfb_marker.size()]
			var direc_bfb = (get_global_mouse_position() - position).normalized()
			mana -= bfb_cost
			$Bluefb_cd.start()
			bluefb.emit(selected_marker.global_position, direc_bfb)	

	if not ani_locked and health!=0 and not health<0:
		if direction.x != 0:
			$player.play("run")
		else:
			$player.play("idle")
			pass	
	$"../CanvasLayer/TextureProgressBar2".value = mana
	attack()
	posi.emit(position)	
	inventory()				
	move_and_slide()

	update_direction()
	_on_player_2d_animation_finished()
	
func inventory():
	if Input.is_action_just_pressed("inventory"):
		print('work')
		if $"../CanvasLayer2".visible == true:
			$"../CanvasLayer2".visible = false
		elif $"../CanvasLayer2".visible == false:
			$"../CanvasLayer2".visible = true

func update_direction():
	
	if direction.x > 0:
		$player.flip_h = false 
	elif direction.x < 0:
		$player.flip_h = true			
		
func jump():
	velocity.y = JUMP_VELOCITY
	$player.play("jump_start")
	ani_locked = true		
func  land():
	$player.play('jump_end')
	ani_locked = true
func attack():
	if Input.is_action_just_pressed("Primary Action") and can_attacked:
		var x = randi() % $Node2D.get_child_count()
		var y = $Node2D.get_children()
		y[x].play()
			
		$player.play('atk')
		can_attacked = false
		$attack/sword.set_deferred("disabled",true)
		$Timer.start()
		ani_locked = true
		can_move = false
	

func _on_player_2d_animation_finished():
	if $player.animation == 'jump_end':
		ani_locked = false
	if  $player.animation == "atk":
		$attack/sword.set_deferred("disabled", false)
		

func _on_timer_timeout():
	can_attacked = true # Replace with function body.
	ani_locked = false
	can_move = true
	$attack/sword.set_deferred("disabled",true)


func _on_fireball_cd_timeout():
	can_fb = true
	pass # Replace with function body.


func _on_bluefb_cd_timeout():
	can_bfb = true
	
	# Replace with function body.


func _on_attack_area_entered(area):
	PlayerPos.dmg_change(1)	
	atk.emit()
	pass # Replace with function body.





func _on_timer_2_timeout():
	hit = false # Replace with function body.


func _on_timer_3_timeout():
	pass


func up_health():
	var health_p =$"../CanvasLayer/TextureProgressBar"
	health_p.value = health

	





func _on_timer_4_timeout():
	if health<max_health and health!=0:
		health += 1	



func _on_level_hurt(d):
	if hit == false:
		$Timer2.start()		
		hit = true
		health -= d
	pass 	
	pass # Replace with function body.
	
	


func _on_timer_5_timeout():
	if mana < PlayerPos.max_mana:
		mana +=1



