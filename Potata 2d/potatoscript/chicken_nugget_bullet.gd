extends RigidBody2D
var lonly = -40



func _on_Area2D_that_has_nice_collusion_body_entered(body):
	body.change_health_by(lonly) 
	queue_free()
	


func _on_u_got_mail_timeout():
	queue_free()
