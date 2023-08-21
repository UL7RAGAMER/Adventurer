extends Node2D
var fireball:PackedScene = preload("res://Player/fireball.tscn")
var bluefb:PackedScene = preload("res://Player/bluefb.tscn")
var boar = preload("res://Player/character_body_2d.tscn")
@onready var mrk1 : Marker2D = $spw1
@onready var mrk2 : Marker2D = $spw2
var num = 0
func _ready():
	pass

func _process(delta):
	num += 1
	var b = boar.instantiate() as CharacterBody2D
	b.position = $spw1.position
	if num == 10:
		add_child(b)
	pass		
func _on_player_fireball(pos, direction):
	var fb = fireball.instantiate() as Area2D
	fb.position = pos
	fb.rotation_degrees = rad_to_deg(direction.angle())
	fb.direction = direction
	$Fireballs.add_child(fb)



func _on_player_bluefb(pos, dir):
	var  bfb = bluefb.instantiate() as RigidBody2D
	bfb.position = pos
	bfb.linear_velocity = dir * 500
	$Fireballs.add_child(bfb)
	pass # Replace with function body.


func _on_player_dead():
	await get_tree().create_timer(1.5).timeout

