extends Node

var ally 
#@onready var ally = GamePersistSg.ally

@onready var enemy = get_parent().get_node("pos_e_1/Char")
@onready var chars=[preload("res://Scenes/char1.tscn"),preload("res://Scenes/char2.tscn"),preload("res://Scenes/char3.tscn"),preload("res://Scenes/char4.tscn"),preload("res://Scenes/char5.tscn"),preload("res://Scenes/char6.tscn")]


@export var turns = 15

signal win
signal lose

func _ready():
	for i in range(len(GamePersistSg.ally)):
		var parent =get_parent().get_node("pos_a_"+str(i+1))
		var child=chars[GamePersistSg.ally[i]].instantiate()
		parent.add_child(child)
		
		
	ally= [get_parent().get_node("pos_a_1/Char"),
get_parent().get_node("pos_a_2/Char"),
get_parent().get_node("pos_a_3/Char"),
get_parent().get_node("pos_a_4/Char")]
	turn(1)
	pass

@export var print_turns = true
func turn(current_turn, single = false):
	if current_turn > turns:
		print("You lose") 
		lose.emit()
		lose2()
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
		
	enemy.g_laugh -= ally[at].g_laugh
	enemy.b_laugh -= ally[at].b_laugh
	enemy.r_laugh -= ally[at].r_laugh
	enemy.update_label()
	if ally[at].hability == 1:
		if at + 1 < 4:
			ally[(at + 1)%GamePersistSg.ALLY_MAX].g_laugh *= 2
			ally[(at + 1)%GamePersistSg.ALLY_MAX].b_laugh *= 2
			ally[(at + 1)%GamePersistSg.ALLY_MAX].r_laugh *= 2
			ally[(at + 1)%GamePersistSg.ALLY_MAX].update_label()
			ally[(at + 1)%GamePersistSg.ALLY_MAX].animate_buff()
	if ally[at].hability == 2:
		ally[at].g_laugh *= 1.3
		ally[at].b_laugh *= 1.3
		ally[at].r_laugh *= 1.3
		ally[at].update_label()
		ally[at].animate_buff()
	
	if enemy.is_dead():
		print("GANHOU")
		win2()
		win.emit()
		return
	await get_tree().create_timer(2).timeout 
	ally[at].unset_turn()
	if ally[at].hability == 3:
		turn(current_turn + 1, true)
		await get_tree().create_timer(2).timeout
	
	if not single:
		turn(current_turn + 1)

func update_turn(x):
	get_parent().get_node("turn_label").text= "Turn: " + str(x)
	pass
	
func win2():
	get_tree().change_scene_to_file("res://Scenes/SelectScreen.tscn")
	
func lose2():
	get_tree().change_scene_to_file("res://Scenes/SelectScreen.tscn")
