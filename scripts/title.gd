extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	get_node("title_sound").play("title")
	pass


func _on_Start_pressed():
	get_tree().change_scene("res://scenes/test_scene.tscn")
	pass # replace with function body


func _on_Exit_pressed():
	get_tree().quit()
	pass # replace with function body
