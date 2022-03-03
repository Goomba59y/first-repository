extends Node2D
var ak_chicken_nugget_ammo     = 30
var speedy_boi                 = 4000
var using                      = true
var shot                       = true
var ak_chicken_nugget_ammo_box = 30
var recoil                     = 0.05
 
func _ready():
	randomize()

func pew_carrot() :
	if shot :
		$AnimatedSprite.play("shoot")
		ak_chicken_nugget_ammo -= 1
		var pew_pew = preload("res://pics/Carrot_bullet.tscn").instance()
		pew_pew.global_position = $Position2D.global_position
		
		pew_pew.apply_impulse(Vector2.ZERO, Vector2(speedy_boi, 0).rotated(global_rotation + rand_range(-recoil, recoil)))
		pew_pew.global_rotation = global_rotation
		get_tree().current_scene.add_child(pew_pew)
		shot = false
		yield($AnimatedSprite,"animation_finished")
		$Timer.start()
		$AnimatedSprite.play("default")


func _on_Timer_timeout():
	shot = true
