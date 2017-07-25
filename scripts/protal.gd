extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export(String, FILE, "*.tscn") var NextScene 

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_Area2D_body_enter( body ):
	if body.is_in_group("player"):
		if NextScene != null:
			get_tree().change_scene(NextScene)
	pass # replace with function body
