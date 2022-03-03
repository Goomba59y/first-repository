extends Node2D
var player     
func _input(event):
	if event.is_action_pressed("e"):
		take_aeman_without_kufor()

func _ready():
	set_process_input(false)
func _on_Area2D_body_entered(body):
	$AnimatedSprite.play("?")
	player = body
	set_process_input(true)

func _on_Area2D_body_exited(body):
	$AnimatedSprite.play("normal")
	set_process_input(false)

func take_aeman_without_kufor():
	$Area2D.queue_free()
	$"1".emitting = true
	$"2".emitting = true
	$"3".emitting = true
	$"4".emitting = true
	yield(get_tree().create_timer(1.8), "timeout")
	$"1".emitting = false
	$"2".emitting = false
	$"3".emitting = false
	$"4".emitting = false
	$CPUParticles2D.emitting = true
	yield(get_tree().create_timer(1),"timeout")
	$CPUParticles2D2.emitting= true
	yield(get_tree().create_timer(0.2),"timeout")
	$Light2D.enabled = true
	yield(get_tree().create_timer(5), "timeout")
	$"5".emitting = true
	$"6".emitting = true
	$"7".emitting = true
	$"8".emitting = true
	yield(get_tree().create_timer(5), "timeout")
	$"9".emitting = true
	$"10".emitting = true
	yield(get_tree().create_timer(0.5), "timeout")
	player.equiped = true
	$AnimatedSprite.queue_free()
	$CPUParticles2D.queue_free()
	$CPUParticles2D2.queue_free()
	$Light2D.queue_free()
