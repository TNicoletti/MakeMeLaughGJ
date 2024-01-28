#Character node
extends Node

@export var g_laugh = 1000
@export var b_laugh = 1000
@export var r_laugh = 1000

func _ready():
	$pb_b.max_value = b_laugh
		
	$pb_g.max_value = g_laugh
	
	$pb_r.max_value = r_laugh
	raw_update_pb()

func raw_update_pb():
	$pb_b.value = b_laugh
	$pb_b/lbl_c.text = str(b_laugh)
	$pb_g.value = g_laugh
	$pb_g/lbl_c.text = str(g_laugh)
	$pb_r.value = r_laugh
	$pb_r/lbl_c.text = str(r_laugh)
	
	if b_laugh <= 0:
		$pb_b.visible = false
		b_laugh_over = true
	if g_laugh <= 0:
		$pb_g.visible = false
		g_laugh_over = true
	if r_laugh <= 0:
		$pb_r.visible = false
		r_laugh_over = true
func update_pb():
	if g_laugh < 0:
		g_laugh = 0
	if r_laugh < 0:
		r_laugh = 0
	if b_laugh < 0:
		b_laugh = 0
	
	await animate_pb()
	
	if b_laugh <= 0:
		$pb_b.visible = false
		b_laugh_over = true
	if g_laugh <= 0:
		$pb_g.visible = false
		g_laugh_over = true
	if r_laugh <= 0:
		$pb_r.visible = false
		r_laugh_over = true
		
var tween
func animate_pb(tween_duration = 2):
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.parallel().tween_property($pb_g, 'value', g_laugh, tween_duration)
	tween.parallel().tween_property($pb_r, 'value', r_laugh, tween_duration)
	tween.parallel().tween_property($pb_b, 'value', b_laugh, tween_duration)
	
	$pb_b/lbl_c.text = str(b_laugh)
	$pb_g/lbl_c.text = str(g_laugh)
	$pb_r/lbl_c.text = str(r_laugh)
	await tween.finished
	
var b_laugh_over = false
var g_laugh_over = false
var r_laugh_over = false
func is_dead(): #Enemy function
	
	return (b_laugh <= 0 or b_laugh_over) and (g_laugh <= 0 or g_laugh_over) and (r_laugh <= 0 or r_laugh_over) 
	
func animate_laugh():
	
	pass
