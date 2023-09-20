extends Node2D

var dmg = 0
var dead = false
var dmg_multiplyer = 1
var max_mana = 100
var mana = max_mana
var mana_multi = 1	
var def = 10
var def_changed = false
var points = 0
var x = load("res://Player/player.tscn")
func _process(delta):

	pass
	
func position():
	var pos1 = $".".position
	var pos2 = $"/root/Level/Player".position
	pos1 = pos2
	return(pos1)
	pass
	$"../AudioStreamPlayer".position = $"../bluefb".position
func dmg_change(dmg1):
	dmg = dmg1 * dmg_multiplyer
	print(dmg)
	
func dmg_multi_changer(con):
	if con == 'yes':
		dmg_multiplyer += 0.1
	if con == 'no':
		dmg_multiplyer -= 0.1
	if con == 'z':
		dmg_multiplyer = 1
		
func mana_change(con):
	if con == 'yes':
		var x =  max_mana * 0.05
		max_mana = max_mana + x
	if con == 'no':
		var x =  max_mana * 0.05
		max_mana = max_mana - x
	if con == 'z':
		max_mana= 100
	
	print(mana_multi)	
func defense_change(con):
	if con == 'yes':
		def += 1
	if con == 'no':
		def -=1
	if con == 'z':
		def = 10
	print(def)
	pass
func _dead():

	points=0
	def = 10
	dmg_multiplyer = 1
	max_mana = 100
	
