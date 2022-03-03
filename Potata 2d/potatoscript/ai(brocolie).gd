extends KinematicBody2D
var health = 501
var speed = 95
var motion = Vector2.ZERO
var potato  = null
var rng_x  
var rng_y 
var you_know_da_rules_so_do_i = 100
var never_gonna_give_u_up = 100
var yeet = true
var energy = 100
var t      = true
var path
onready var flame_thrower = $Node2D

enum{
	TELEPORT,
	FINISHED
}



func _ready():
	randomize()
	
	

func _physics_process(delta):
	if potato != null:
		flame_thrower.look_at(potato.global_position)
		if potato.global_position.distance_to(global_position) >= 120:
			if t == true :
				_on_stop_put_ur_hands_up_body_exited()
				t = false

func health_checker() :
	if health <= 0 :
		potato = get_tree().get_root().find_node("Potata")
		queue_free()
	
func change_health_by(value):
	$ouch.emitting = true
	$AnimatedSprite.play("ouch")
	health += value
	$Timer.start()


func _on_Area2D_body_entered(body):
	potato = body
	set_physics_process(true)


func _on_Area2D_body_exited(_body):
	set_physics_process(false)


func _on_stop_put_ur_hands_up_body_entered():
	teleportation_jitsu(potato)
	flame_thrower.visible = true
	$AnimatedSprite.play("behind_u")
	yield($AnimatedSprite,"animation_finished")
	$AnimatedSprite.play("idle")
	$t_timer.start(0.5)

func teleportation_jitsu(potato):
	Nodes.get_meta("Navi").Navi(self, global_position, potato.global_position)
	rng_x = rand_range(-you_know_da_rules_so_do_i, you_know_da_rules_so_do_i)
	rng_y = rand_range(-never_gonna_give_u_up, never_gonna_give_u_up)
	path.invert()
	if path.empty() != true:
		global_position = path[0] 


func _on_stop_put_ur_hands_up_body_exited():
	$AnimatedSprite.play("teleport")
	$behind.emitting = true
	$u.emitting = true
	flame_thrower.visible = false
	yield($AnimatedSprite,"animation_finished")
	_on_stop_put_ur_hands_up_body_entered()
	yeet = true
	


func right_entered(body):
	flame_thrower.position.x = 10
	flame_thrower.get_node("AnimatedSprite").flip_v = false
	$AnimatedSprite.flip_h = true


func left_entered(body):
	flame_thrower.position.x = -7
	flame_thrower.get_node("AnimatedSprite").flip_v = true
	$AnimatedSprite.flip_h = false




func _on_attack_area_body_entered(body):
	flame_thrower.get_node("AnimatedSprite").play("fire")


func _on_attack_area_body_exited(body):
	pass


func name_getter(body):
	if body.name == "Potata":
		potato = body




func _on_Timer_health():
	health_checker()
	$AnimatedSprite.play("idle")


func _on_t_timer_timeout():
	t = true
