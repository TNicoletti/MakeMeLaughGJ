#Enemy node
extends Node

@export var g_laugh = 200
@export var b_laugh = 200
@export var r_laugh = 200
@export var y_laugh = 200

func is_dead():
	return b_laugh < 0 and g_laugh < 0 and r_laugh < 0 and y_laugh < 0
