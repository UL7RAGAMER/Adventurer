extends Node2D
var fireball:PackedScene = preload("res://Player/fireball.tscn")
var bluefb:PackedScene = preload("res://Player/bluefb.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_fireball(pos, direction):
	var fb = fireball.instantiate() as Area2D
	fb.position = pos
	fb.rotation_degrees = rad_to_deg(direction.angle())
	fb.direction = direction
	$Fireballs.add_child(fb)
	print('fireball') # Replace with function body.


func _on_player_bluefb(pos, dir):
	var  bfb = bluefb.instantiate() as RigidBody2D
	bfb.position = pos
	bfb.linear_velocity = dir * 500
	$Fireballs.add_child(bfb)
	pass # Replace with function body.
