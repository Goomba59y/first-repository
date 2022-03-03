extends AnimatedSprite


func _on_Area2D_mouse_entered():
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("right_click"):
		print("gaY")
	pass
