#Character node
extends Node

@export var g_laugh = 1000
@export var b_laugh = 1000
@export var r_laugh = 1000

func _ready():
	if b_laugh == 0:
		$pb_b.max_value = 1
		$pb_b.value = 0
	else:
		$pb_b.max_value = b_laugh
		$pb_b.value = b_laugh
	if g_laugh == 0:
		$pb_g.max_value = 1
		$pb_g.value = 0
	else:
		$pb_g.max_value = g_laugh
		$pb_g.value = g_laugh
	if r_laugh == 0:
		$pb_r.max_value = 1
		$pb_r.value = 0
	else:
		$pb_r.max_value = r_laugh
		$pb_r.value = r_laugh
	update_pb()

func update_pb():
	$pb_b.value = b_laugh
	$pb_b/lbl_c.text = str(b_laugh)
	$pb_g.value = g_laugh
	$pb_g/lbl_c.text = str(g_laugh)
	$pb_r.value = r_laugh
	$pb_r/lbl_c.text = str(r_laugh)
	

func is_dead(): #Enemy function
	return b_laugh < 0 and g_laugh < 0 and r_laugh < 0 
	
func animate_laugh():
	
	pass
