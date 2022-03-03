extends Node2D
var speedy_boi= 1000
var direction = RIGHT
var K_M47AMMO = 16
var K_M47AMMO_box = 16
var ded       = true
var max_bullets = 16
var alive     = true
var shot      = true
const max_ammo= 16
var remaining_ammo = 0
var work = true

enum{
	LEFT,
	RIGHT,
	RELOAD
}


func _physics_process(_delta):
	if alive == false :
		set_physics_process(false)
	print(work)
	print(K_M47AMMO_box)
	
	if work == true :
		if K_M47AMMO != 0:
			$AnimatedSprite.play("load1")
		if K_M47AMMO == 0:
			$AnimatedSprite.play("idle")
	
	match direction:
		LEFT:
			$AnimatedSprite.flip_v = true
			rotation_degrees = clamp(rotation_degrees, -100, 100)
		RIGHT:
			rotation_degrees = clamp(rotation_degrees, -70, 70)
			$AnimatedSprite.flip_v = false
	
	if Input.is_action_just_pressed("R") :
		print("poop")
		if visible :
			if K_M47AMMO < 16:
				if K_M47AMMO_box > 0:
					shot = false
					work = false
					var ammo_calcualtor = max_ammo - K_M47AMMO
					if ammo_calcualtor > K_M47AMMO_box:
						K_M47AMMO += K_M47AMMO_box
						K_M47AMMO_box = 0
						shot = true
						work = true
					else:
						shot = false
						work = false
						K_M47AMMO_box -= ammo_calcualtor
						$AnimatedSprite.play("reload")
						yield($AnimatedSprite,"animation_finished")
						shot = true
						work = true
						K_M47AMMO += ammo_calcualtor
					
				
			
	
	if visible :
		look_at(get_global_mouse_position())
		$Position2D.look_at(get_global_mouse_position())
		
		if Input.is_action_just_pressed("left_click") :
			if K_M47AMMO > 0 :
				if shot :
					$AnimatedSprite.play("shoot")
					work = false
					K_M47AMMO -= 1
					$AudioStreamPlayer2D.play()
					var pew_pew = preload("res://pics/potatoScens/bullet.tscn").instance()
					pew_pew.global_position = $Position2D.global_position
					pew_pew.apply_impulse(Vector2.ZERO, Vector2(speedy_boi, 0).rotated(global_rotation))
					pew_pew.global_rotation = global_rotation
					get_tree().current_scene.add_child(pew_pew)
					yield($AnimatedSprite,"animation_finished")
					work = true
	
	
	
	if Input.is_action_just_pressed("1"):
		visible = not visible  
	
	if Input.is_action_pressed("right"):
		direction = RIGHT
	
	if Input.is_action_pressed("left"):
		direction = LEFT
	
func save_data():
	Cache.set_meta("K_M47AMMO", K_M47AMMO)
	Cache.set_meta("K_M47AMMO_box", K_M47AMMO_box)




func load_data():
	K_M47AMMO = Cache.data.K_M47AMMO
	K_M47AMMO_box = Cache.data.K_M47AMMO_box
	print("gae")
