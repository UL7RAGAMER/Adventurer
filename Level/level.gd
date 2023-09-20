extends Node2D
var fireball:PackedScene = preload("res://Player/fireball.tscn")
var bluefb:PackedScene = preload("res://Player/bluefb.tscn")
var bfb_aud:PackedScene = preload("res://Player/bfb_aud.tscn")
var bfb_ani = preload("res://Player/bfb_ani.tscn")
var boar = load("res://Player/character_body_2d.tscn")
@onready var mrk1 : Marker2D = $spw1
@onready var mrk2 : Marker2D = $spw2
var num = 0
signal hurt()
func _ready():
	pass
signal dmg(dmg) 
func _process(delta):
	num += 1
	$CanvasLayer2/Control/Panel2/Label2.set_text(str(PlayerPos.points))
	var pos1 = $spw1.position
	var pos2 = $spw2.position
	var f_pos = pos1
	f_pos.x = randi_range(pos1.x,pos2.x) 
	var b = boar.instantiate() as CharacterBody2D
	b.position = f_pos
	if num<5:
		add_child(b)
	b.player_hurt.connect(_on_character_body_2d_player_hurt)
	if PlayerPos.dead == true:
		b.queue_free()
		
	
pass		
func _on_player_fireball(pos, direction):
	var fb = fireball.instantiate() as Area2D
	fb.position = pos
	fb.rotation_degrees = rad_to_deg(direction.angle())
	fb.direction = direction
	print(fb.position,fb.rotation_degrees,fb.direction)
	$Fireballs.add_child(fb)
	$Fireballs/Fireball/AudioStreamPlayer2D.play()
	await get_tree().create_timer(3).timeout
	$Fireballs/Fireball/fireball.play("fizziling")
	$Fireballs/Fireball/CollisionShape2D.set_deferred("disabled",true)
	for i in range(0,153):
		$Fireballs/Fireball/GPUParticles2D.amount -= 1
	
	await $Fireballs/Fireball/fireball.animation_finished
	fb.queue_free()



func _on_player_bluefb(pos, dir):
	var  bfb = bluefb.instantiate() as Area2D
	var bfb_aud1 = bfb_aud.instantiate() as AudioStreamPlayer2D
	var bfb_ani1 = bfb_ani.instantiate() as AnimatedSprite2D
	bfb.position = pos
	bfb_aud1.position = pos
	bfb_ani1.position = pos
	bfb.rotation_degrees = rad_to_deg(dir.angle())
	bfb_aud1.rotation_degrees = rad_to_deg(dir.angle())
	bfb_ani1.rotation_degrees = rad_to_deg(dir.angle())
	bfb.direction = dir
	bfb_aud1.direction = dir
	bfb_ani1.direction = dir
	$Fireballs.add_child(bfb)
	$Fireballs.add_child(bfb_aud1)
	$Fireballs.add_child(bfb_ani1)	
	
	await get_tree().create_timer(6.671).timeout
	bfb.queue_free()





func _on_character_body_2d_player_hurt():
	hurt.emit(1)
	



func _on_button_pressed():
	if PlayerPos.points > 0:
		PlayerPos.points -= 1
		PlayerPos.dmg_multi_changer('yes')
		var stat_dmg = PlayerPos.dmg_multiplyer
		
		$CanvasLayer2/Control/Panel2/Control/Label.set_text(str(stat_dmg))
	


func _on_button_2_pressed():
	if PlayerPos.dmg_multiplyer !=1:
		PlayerPos.points += 1
		PlayerPos.dmg_multi_changer('no')
		
		if PlayerPos.dmg_multiplyer <=0:
			PlayerPos.dmg_multi_changer('z')
			
		var stat_dmg = PlayerPos.dmg_multiplyer
		$CanvasLayer2/Control/Panel2/Control/Label.set_text(str(stat_dmg))
		
		pass # Replace with function body.


func _on_button_3_pressed():
	if PlayerPos.points > 0:
		PlayerPos.points -= 1
		PlayerPos.mana_change('yes')
		
		if PlayerPos.max_mana <=100:
			PlayerPos.mana_change('z')
			
		var stat_mana = PlayerPos.max_mana
		stat_mana = round(stat_mana)
		$CanvasLayer2/Control/Panel2/Control2/Label2.set_text(str(stat_mana))
		pass # Replace with function body.


func _on_button_4_pressed():
	if PlayerPos.max_mana != 100:
		PlayerPos.points += 1
		await get_tree().create_timer(0.1).timeout
		if PlayerPos.max_mana <=100:
			PlayerPos.mana_change('z')
		else:
			PlayerPos.mana_change('no')
		

		var stat_mana = PlayerPos.max_mana
		stat_mana = round(stat_mana)
		$CanvasLayer2/Control/Panel2/Control2/Label2.set_text(str(stat_mana))
	pass # Replace with function body.


func _on_button_5_pressed():
	if PlayerPos.points > 0:
		PlayerPos.points -= 1

		PlayerPos.defense_change('yes')
		

		var stat_def = PlayerPos.def
		$CanvasLayer2/Control/Panel2/Control3/Label3.set_text(str(stat_def))

		pass # Replace with function body.


func _on_button_6_pressed():
	if PlayerPos.def != 10:
		PlayerPos.points += 1
		if PlayerPos.def <=10:
			PlayerPos.defense_change('z')
		else:
			PlayerPos.defense_change('no')
		

		var stat_def = PlayerPos.def

		$CanvasLayer2/Control/Panel2/Control3/Label3.set_text(str(stat_def))
	
	pass # Replace with function body.


func _on_boar_player_hurt_1():
	hurt.emit(3)
	pass # Replace with function body.


func _on_player_dead():
	PlayerPos._dead()
	pass # Replace with function body.
