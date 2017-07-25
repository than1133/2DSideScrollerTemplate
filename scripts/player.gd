extends KinematicBody2D

# ประกาศตัวแปล
# เก็บความเร็วสูงสุดของผู้เล่น
const MAX_PLAYER_SPEED = 10
# เก็บความเร็วผู้เล่น
export(float) var player_speed = 100
# เก็บทิศทางผู้เล่น
var player_direction = -1
# เก็บค่าแรงโนมถ่วง
const gravity = 70
# เก็บค่า การกระโดดสูงสุด
const MAX_JUMP_HIGHT = 20
# เก็บค่าเร่งกระโดดของผู้เล่น
var jump_accelerator = 5000
# เก็บค่าการเคลื่อนที่
var velocity = Vector2()

# เก็บโนดของเรย์แคส
var ray
# เก็บภาพตัวละคร
var player_sprite
# เก็บโนดของกราฟิกผู้ใช้
var gui
# เก็บค่าเสียง
var sound

var game_end = false

#เมื่อตัวละครเริ่มทำงาน
func _ready():
	ray = get_node("RayCast2D")
	ray.add_exception(self)
	player_sprite = get_node("AnimatedSprite")
	gui = get_node("CanvasLayer/gui")
	sound = get_node("player_sound")
	set_fixed_process(true)
	pass

#ระหว่างตัวละครอยู่ในฉาก
func _fixed_process(delta):
	# เช็คจบเกม
	if game_end == false:
		#สร้างตัวแปรเก็บค่าการกดคีย์บอร์ด
		var move_left = Input.is_action_pressed("ui_left")
		var move_right = Input.is_action_pressed("ui_right")
		var jump = Input.is_action_pressed("jump")
		
		# การเครื่อนที่
		if move_left or gui.right:
			if player_direction == 1:
				velocity.x = 0
			player_direction = -1
			velocity.x -= player_speed*delta
			velocity.x = clamp(velocity.x, -MAX_PLAYER_SPEED, 0)
			player_sprite.set_animation("walk")
			player_sprite.set_flip_h(true)
			if !sound.is_active():
				sound.play("run")
		elif move_right:
			if player_direction == -1:
				velocity.x = 0
			player_direction = 1
			velocity.x += player_speed*delta
			velocity.x = clamp(velocity.x, 0, MAX_PLAYER_SPEED)
			player_sprite.set_animation("walk")
			player_sprite.set_flip_h(false)
			if !sound.is_active():
				sound.play("run")
		else:
			if !jump:
				sound.stop_all()
			velocity.x = 0
			player_sprite.set_animation("idle")
	
		# แรงโน้มถ่วงและการกระโดด
		if !ray.is_colliding():
			velocity.y+=gravity*delta
			player_sprite.set_animation("jump")
		else:
			if jump:
				velocity.y-=jump_accelerator*delta
				velocity.y = clamp(velocity.y, -MAX_JUMP_HIGHT, 0)
				sound.play("jump")
			else:
				velocity.y = 0
		move(velocity)

#เช็คการชนของตัวละครกับวัตถุ
func _on_Area2D_body_enter( body ):
	if body.is_in_group("multi"):
		body.queue_free()
		gui.increase_score()
		get_node("bright_sound").play("bright")
	elif body.is_in_group("goal"):
		game_end = true
		gui.set_show_end_game()
	pass # replace with function body
