extends Control

var MAX_LEVEL = 3

# Called when the node enters the scene tree for the first time.
@onready var chars=[preload("res://Scenes/char1.tscn").instantiate(),preload("res://Scenes/char2.tscn").instantiate(),preload("res://Scenes/char3.tscn").instantiate(),preload("res://Scenes/char4.tscn").instantiate(),preload("res://Scenes/char5.tscn").instantiate(),preload("res://Scenes/char6.tscn").instantiate()]

func _ready():
	if GamePersistSg.level > MAX_LEVEL:
		pass
	if GamePersistSg.level == 3:
		GamePersistSg.ally[3] = 5
		$HBoxContainer/VBoxContainer4/CenterContainer/BotaoSuperior.disabled = true
		$HBoxContainer/VBoxContainer4/CenterContainer/BotaoSuperior.modulate = "5500ab"
		$HBoxContainer/VBoxContainer4/CenterContainer2/BotaoInferior.disabled = true
		$HBoxContainer/VBoxContainer4/CenterContainer2/BotaoInferior.modulate = "5500ab"
	for i in range(4):
		update_labels(i)

func _on_botao_superior1_pressed(id):
	GamePersistSg.ally[id]=(GamePersistSg.ally[id]+1)%GamePersistSg.ALLY_MAX
	update_labels(id)

func update_labels(id):
	var a = GamePersistSg.ally[id]
	var st = chars[a].hability_description
	if st == "":
		st = "This character does nothing"
	if id == 0:
		$HBoxContainer/VBoxContainer/lbl_b.text = str(chars[a].b_laugh)
		$HBoxContainer/VBoxContainer/lbl_g.text = str(chars[a].g_laugh)
		$HBoxContainer/VBoxContainer/lbl_r.text = str(chars[a].r_laugh)
		$HBoxContainer/VBoxContainer/hab_desc.text = st
		$HBoxContainer/VBoxContainer/TextureRect.texture = chars[a].get_node("Head").texture
	elif id == 1:
		$HBoxContainer/VBoxContainer2/lbl_b.text = str(chars[a].b_laugh)
		$HBoxContainer/VBoxContainer2/lbl_g.text = str(chars[a].g_laugh)
		$HBoxContainer/VBoxContainer2/lbl_r.text = str(chars[a].r_laugh)
		$HBoxContainer/VBoxContainer2/hab_desc.text = st
		$HBoxContainer/VBoxContainer2/TextureRect.texture = chars[a].get_node("Head").texture
	elif id == 2:
		$HBoxContainer/VBoxContainer3/lbl_b.text = str(chars[a].b_laugh)
		$HBoxContainer/VBoxContainer3/lbl_g.text = str(chars[a].g_laugh)
		$HBoxContainer/VBoxContainer3/lbl_r.text = str(chars[a].r_laugh)
		$HBoxContainer/VBoxContainer3/hab_desc.text = st
		$HBoxContainer/VBoxContainer3/TextureRect.texture = chars[a].get_node("Head").texture
	elif id == 3:
		$HBoxContainer/VBoxContainer4/lbl_b.text = str(chars[a].b_laugh)
		$HBoxContainer/VBoxContainer4/lbl_g.text = str(chars[a].g_laugh)
		$HBoxContainer/VBoxContainer4/lbl_r.text = str(chars[a].r_laugh)
		$HBoxContainer/VBoxContainer4/hab_desc.text = st
		$HBoxContainer/VBoxContainer4/TextureRect.texture = chars[a].get_node("Head").texture
func _on_botao_inferior1_pressed(id):
	GamePersistSg.ally[id]-=1
	if GamePersistSg.ally[id]==-1:
		GamePersistSg.ally[id]+=GamePersistSg.ALLY_MAX
	update_labels(id)


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main.tscn")
