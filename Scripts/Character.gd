#Character node
extends Node

@export var char_name = "PLACEHOLDER"

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

func set_turn():
	$is_turn.visible = true
	$attackS.play()
	pass

func unset_turn():
	$is_turn.visible = false
	pass
	
func animate_buff():
	var aux = $Sprite.modulate
	$Sprite.modulate = "00cf6b"
	await get_tree().create_timer(2).timeout 
	$Sprite.modulate = aux
	pass
	
func animate_debuff():
	var aux = $Sprite.modulate
	$Sprite.modulate = "d70061"
	await get_tree().create_timer(2).timeout 
	$Sprite.modulate = aux
	pass
	
func animate_laugh():
	
	pass
