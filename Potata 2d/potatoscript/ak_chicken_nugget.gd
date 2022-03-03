extends Node2D
var ak_chicken_nugget_ammo = 30
var speedy_boi             = 1600
var using                  = true
var shot                   = true
var ak_chicken_nugget_ammo_box = 30
var alive                  = true
var max_ammo               = 30
var ammo_fixer             = max_ammo - ak_chicken_nugget_ammo

func _physics_process(delta):
	if alive == false :
		set_physics_process(false)
	
	if Input.is_action_just_pressed("R") :
		if visible :
			shot = false
			if ak_chicken_nugget_ammo_box > 0:
				var ammo_calcualtor = 30 - ak_chicken_nugget_ammo
				if ammo_calcualtor > ak_chicken_nugget_ammo_box:
					ak_chicken_nugget_ammo += ak_chicken_nugget_ammo_box
					ak_chicken_nugget_ammo_box = 0
					shot = true
				else:
					ak_chicken_nugget_ammo_box -= ammo_calcualtor
					$AnimatedSprite.play("reload")
					yield($AnimatedSprite,"animation_finished")
					shot = true
					ak_chicken_nugget_ammo += ammo_calcualtor
	if ak_chicken_nugget_ammo > max_ammo:
		ak_chicken_nugget_ammo_box + ammo_fixer
		ak_chicken_nugget_ammo = 30
	
	if visible :
		look_at(get_global_mouse_position())
	
	if shot :
		if Input.is_action_pressed("left_click") :
			if ak_chicken_nugget_ammo > 0 :
				if visible :
					$AnimatedSprite.play("shoot")
					$Light2D.enabled = true
					ak_chicken_nugget_ammo -= 1
					var pew_pew = preload("res://pics/chicken_nugget_bullet.tscn").instance()
					pew_pew.global_position = $Position2D.global_position
					pew_pew.apply_impulse(Vector2.ZERO, Vector2(speedy_boi, 0).rotated(global_rotation))
					pew_pew.global_rotation = global_rotation
					get_tree().current_scene.add_child(pew_pew)
					shot = false
					$AudioStreamPlayer.play()
					yield($AnimatedSprite,"animation_finished")
					$Light2D.enabled = false
					$AnimatedSprite.play("default")
					yield(get_tree().create_timer(0.05),"timeout")
					shot = true
	
	if Input.is_action_just_pressed("1"):
		visible = not visible  
	
	if Input.is_action_pressed("right"):
		$AnimatedSprite.flip_v = false
		$Position2D.position.y = -3
		$Light2D.position.y = -3
	
	if Input.is_action_pressed("left"):
		$AnimatedSprite.flip_v = true
		$Position2D.position.y = 3
		$Light2D.position.y = 3
	
