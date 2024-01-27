extends Control


# Called when the node enters the scene tree for the first time.




func _on_botao_superior1_pressed(id):
	GamePersistSg.ally[id]=(GamePersistSg.ally[id]+1)%GamePersistSg.ALLY_MAX
	


func _on_botao_inferior1_pressed(id):
	GamePersistSg.ally[id]-=1
	if GamePersistSg.ally[id]==-1:
		GamePersistSg.ally[id]+=GamePersistSg.ALLY_MAX
