extends CharacterBody2D

signal fireball(position,direction )
signal bluefb(position, direction)

const SPEED = 200.0
const JUMP_VELOCITY = -200.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var ani_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var was_in_air : bool = false
var can_attacked : bool = true
var can_fb : bool = true
var can_bfb : bool = true
func _physics_process(delta):
	# Add the gravity.
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
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("Left", "Right", "None", 'None')
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if Input.is_action_pressed("Right"):
		get_node("attack").set_scale(Vector2(1, 1))
	elif Input.is_action_pressed("Left"): 
		get_node("attack").set_scale(Vector2(-1, 1))
		
	if Input.is_action_just_pressed("fireball") and can_fb:
		can_fb = false
		var fb_markers  = $Fireball_pos.get_children()
		var selected_marker = fb_markers[randi() % fb_markers.size()]
		var direc_fb = (get_global_mouse_position() - position).normalized()
		print(selected_marker)
		$Fireball_cd.start()
		fireball.emit(selected_marker.global_position, direc_fb)	
	if Input.is_action_just_pressed("bluefb") and can_bfb:
		can_bfb = false
		var  bfb_marker = $Fireball_pos2.get_children()
		var selected_marker = bfb_marker[randi() % bfb_marker.size()]
		var direc_bfb = (get_global_mouse_position() - position).normalized()
		$Bluefb_cd.start()
		bluefb.emit(selected_marker.global_position, direc_bfb)	
	attack()	
	move_and_slide()
	update_animation()
	update_direction()
	_on_animated_sprite_2d_animation_finished()
	
func update_animation():
	if not ani_locked:
		if direction.x != 0:
			animated_sprite.play("run")
		else:
			animated_sprite.play("idle")	
func update_direction():
	if direction.x > 0:
		animated_sprite.flip_h = false 
	elif direction.x < 0:
		animated_sprite.flip_h = true			
		
func jump():
	velocity.y = JUMP_VELOCITY
	animated_sprite.play("jump_start")
	ani_locked = true		
func  land():
	animated_sprite.play('jump_end')
	ani_locked = true
func attack():
	if Input.is_action_just_pressed("Primary Action") and can_attacked:

		animated_sprite.play('atk')
		can_attacked = false
		$attack/sword.set_deferred("disabled",true)
		$Timer.start()
		ani_locked = true
		
	

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == 'jump_end':
		ani_locked = false
	if  animated_sprite.animation == "atk":
		$attack/sword.set_deferred("disabled", false)

func _on_timer_timeout():
	can_attacked = true # Replace with function body.
	ani_locked = false
	$attack/sword.set_deferred("disabled",true)


func _on_fireball_cd_timeout():
	can_fb = true
	pass # Replace with function body.


func _on_bluefb_cd_timeout():
	can_bfb = true
	
	# Replace with function body.
