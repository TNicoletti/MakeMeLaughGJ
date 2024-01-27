extends Node

@onready var ally_1 = get_parent().get_node("pos_a_1/Char")
@onready var ally_2 = get_parent().get_node("pos_a_2/Char")
@onready var ally_3 = get_parent().get_node("pos_a_1/Char")
@onready var ally_4 = get_parent().get_node("pos_a_1/Char")

@onready var enemy = get_parent().get_node("pos_e_1")

@export var turns = 15
@export var current_turn = 0

func _ready():
	
	pass

func turn():
	
