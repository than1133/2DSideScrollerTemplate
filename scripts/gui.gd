extends Control

onready var score = 0
var sfx
var right = false

func _ready():
	sfx = get_node("sfx")
	sfx.play("in_scene")
	pass
	
func set_player_collision_state(n=0):
	get_node("debug/player_collision_state").set_text("player collision state: "+str(n))
	pass

func increase_score():
	score+=1
	set_player_score(score)

func set_player_score(n=0):
	get_node("ui/Score").set_text("x "+str(n))
	
func set_show_end_game():
	sfx.play("complete")
	get_node("ui/EndGame").show()
	pass

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/title.tscn")
	pass # replace with function body


func _on_right_pressed():
	right = true
	pass # replace with function body


func _on_right_released():
	right = false
	pass # replace with function body
