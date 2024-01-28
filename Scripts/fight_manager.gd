extends Node

var ally 
var enemy

@onready var enemy_pre = [preload("res://Scenes/en1.tscn"), preload("res://Scenes/en2.tscn"), preload("res://Scenes/en3.tscn"), preload("res://Scenes/en2.tscn"), preload("res://Scenes/en4.tscn")]
@onready var chars=[preload("res://Scenes/char1.tscn"),preload("res://Scenes/char2.tscn"),preload("res://Scenes/char3.tscn"),preload("res://Scenes/char4.tscn"),preload("res://Scenes/char5.tscn"),preload("res://Scenes/char6.tscn")]

@export var turns = 15

signal win_signal
signal lose_signal

func _ready():
	get_parent().get_node("Ui-level/level_label").text = str(GamePersistSg.level + 1)
	
	enemy = enemy_pre[GamePersistSg.level].instantiate()
	get_parent().get_node("pos_e_1").add_child(enemy)
	for i in range(len(GamePersistSg.ally)):
		var parent =get_parent().get_node("pos_a_"+str(i+1))
		var child=chars[GamePersistSg.ally[i]].instantiate()
		parent.add_child(child)
		
		
	ally= [get_parent().get_node("pos_a_1/Char"),
get_parent().get_node("pos_a_2/Char"),
get_parent().get_node("pos_a_3/Char"),
get_parent().get_node("pos_a_4/Char")]
	await get_tree().create_timer(2).timeout
	turn(1)
	pass

@export var print_turns = true
func turn(current_turn, single = false):
	if current_turn > turns:
		if print_turns:
			print("You lose") 
		lose()
		return #loose
	update_turn(current_turn)
	var at = (current_turn - 1) % 4
	ally[at].set_turn()
	
	if print_turns:
		print("turn " + str(current_turn))
		print(str(enemy.g_laugh) + " -= " + str(ally[at].g_laugh))
		print(str(enemy.b_laugh) + " -= " + str(ally[at].b_laugh))
		print(str(enemy.r_laugh) + " -= " + str(ally[at].r_laugh))
		print("hability " + str(ally[at].hability))
		
	get_parent().get_node("Haha/AnimationPlayer").play("Hahaha")
	enemy.g_laugh -= ally[at].g_laugh
	enemy.b_laugh -= ally[at].b_laugh
	enemy.r_laugh -= ally[at].r_laugh
	enemy.update_pb()
	if ally[at].hability == 1:
		var oldg = ally[(at + 1)%GamePersistSg.ALLY_QTD].g_laugh
		var oldb = ally[(at + 1)%GamePersistSg.ALLY_QTD].b_laugh
		var oldr = ally[(at + 1)%GamePersistSg.ALLY_QTD].r_laugh
		ally[(at + 1)%GamePersistSg.ALLY_QTD].g_laugh *= 2
		ally[(at + 1)%GamePersistSg.ALLY_QTD].b_laugh *= 2
		ally[(at + 1)%GamePersistSg.ALLY_QTD].r_laugh *= 2
		ally[(at + 1)%GamePersistSg.ALLY_QTD].update_label()
		ally[(at + 1)%GamePersistSg.ALLY_QTD].animate_buff()
		ally[(at - 1)%GamePersistSg.ALLY_QTD].g_laugh -= oldg
		ally[(at - 1)%GamePersistSg.ALLY_QTD].b_laugh -= oldb
		ally[(at - 1)%GamePersistSg.ALLY_QTD].r_laugh -= oldr
		ally[(at - 1)%GamePersistSg.ALLY_QTD].update_label()
		ally[(at - 1)%GamePersistSg.ALLY_QTD].animate_debuff()
	if ally[at].hability == 2:
		ally[at].g_laugh *= 1.5
		ally[at].b_laugh *= 1.5
		ally[at].r_laugh *= 1.5
		ally[at].update_label()
		ally[at].animate_buff()
	if ally[at].hability == 4:
		ally[(at + 1)%GamePersistSg.ALLY_QTD].g_laugh += ally[at].g_laugh
		ally[(at + 1)%GamePersistSg.ALLY_QTD].b_laugh += ally[at].b_laugh
		ally[(at + 1)%GamePersistSg.ALLY_QTD].r_laugh += ally[at].r_laugh
		ally[(at + 1)%GamePersistSg.ALLY_QTD].update_label()
		ally[(at + 1)%GamePersistSg.ALLY_QTD].animate_buff()
	if ally[at].hability == 5:
		var high = 0
		var hs
		var low = 2000000000
		var hl
		for i in ally:
			var aux = i.g_laugh + i.b_laugh + i.r_laugh
			if aux > high:
				high = aux
				hs = i
			if aux < low:
				low = aux
				hl = i
		var save_g = hl.g_laugh
		var save_b = hl.b_laugh
		var save_r = hl.r_laugh
		hl.g_laugh = hs.g_laugh
		hl.r_laugh = hs.r_laugh
		hl.b_laugh = hs.b_laugh
		hs.g_laugh = save_g
		hs.r_laugh = save_r
		hs.b_laugh = save_b
		hs.animate_debuff()
		hs.update_label()
		hl.animate_buff()
		hl.update_label()
			
	
	await get_tree().create_timer(2).timeout
	if enemy.is_dead():
		if print_turns:
			print("GANHOU")
		win()
		return
	if ally[at].hability == 3:
		turn(current_turn + 1, true)
		await get_tree().create_timer(2).timeout
	ally[at].unset_turn()
	if not single:
		turn(current_turn + 1)

func update_turn(x):
	get_parent().get_node("Ui-turn/turn_label").text = str(x)
	pass
	
func win():
	GamePersistSg.level += 1
	win_signal.emit()
	if GamePersistSg.level >= GamePersistSg.MAX_LEVEL:
		get_tree().change_scene_to_file("res://Scenes/final_win.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/win_scene.tscn")
	
	
func lose():
	get_tree().change_scene_to_file("res://Scenes/lose_scene.tscn")
	lose_signal.emit()
