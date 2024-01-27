#Character node
extends Node

@export var g_laugh = 10
@export var b_laugh = 10
@export var r_laugh = 10


@export var hability = 0
@export var hability_description = ""

func _ready():
	update_label()

func update_label():
	$g_label.text = str(g_laugh)
	$r_label.text = str(r_laugh)
	$b_label.text = str(b_laugh)
	
func is_dead(): #Enemy function
	return b_laugh < 0 and g_laugh < 0 and r_laugh < 0 

func set_turn():
	$is_turn.visible = true
	pass

func unset_turn():
	$is_turn.visible = false
	pass
	
func animate_buff():
	$Sprite.modulate = "green"
	await get_tree().create_timer(2).timeout 
	$Sprite.modulate = "white"
	pass
	
func animate_debuff():
	$Sprite.modulate = "red"
	await get_tree().create_timer(2).timeout 
	$Sprite.modulate = "white"
	pass
	
func animate_laugh():
	
	pass
