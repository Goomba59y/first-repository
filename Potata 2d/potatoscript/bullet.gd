extends RigidBody2D
var lonly = -40





func _on_Area2D_that_has_nice_collusion_body_entered(body):
	if body.name != "Potata":
		if body.name != "TileMap" :
			if body.name != "TileMap2" :
				if body.name != "TileMap3" :
					body.change_health_by(lonly) 
	queue_free()
	


func _on_u_got_mail_timeout():
	queue_free()
