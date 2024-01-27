extends Node

@onready var ally = [get_parent().get_node("pos_a_1/Char"),
get_parent().get_node("pos_a_2/Char"),
get_parent().get_node("pos_a_3/Char"),
get_parent().get_node("pos_a_4/Char")]
#@onready var ally = GamePersistSg.ally

@onready var enemy = get_parent().get_node("pos_e_1")

@export var turns = 15

signal win
signal lose

func _ready():
	turn(1)
	pass

@export var print_turns = true
func turn(current_turn, single = false):
	if current_turn > turns:
		print("You lose") 
		lose.emit()
		return #loose
	var at = (current_turn - 1) % 4
	
	if print_turns:
		print("turn " + str(current_turn))
		print(str(enemy.g_laugh) + " -= " + str(ally[at].g_laugh))
		print(str(enemy.b_laugh) + " -= " + str(ally[at].b_laugh))
		print(str(enemy.r_laugh) + " -= " + str(ally[at].r_laugh))
		print(str(enemy.y_laugh) + " -= " + str(ally[at].y_laugh))
		print("hability " + str(ally[at].hability))
		
	enemy.g_laugh -= ally[at].g_laugh
	enemy.b_laugh -= ally[at].b_laugh
	enemy.r_laugh -= ally[at].r_laugh
	enemy.y_laugh -= ally[at].y_laugh
	if ally[at].hability == 1:
		if at + 1 < 4:
			ally[at + 1].g_laugh *= 2
			ally[at + 1].b_laugh *= 2
			ally[at + 1].r_laugh *= 2
			ally[at + 1].y_laugh *= 2
			ally[at + 1].update_label()
	if ally[at].hability == 2:
		ally[at].g_laugh *= 1.3
		ally[at].b_laugh *= 1.3
		ally[at].r_laugh *= 1.3
		ally[at].y_laugh *= 1.3
		ally[at].update_label()
	
	if enemy.is_dead():
		print("GANHOU")
		win.emit()
		return
	if ally[at].hability == 3:
		turn(current_turn + 1, true)
	
	if not single:
		turn(current_turn + 1)
