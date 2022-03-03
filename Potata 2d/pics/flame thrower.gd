extends Node2D
var damage = 2
var yes    = false
var potata = null

func _physics_process(delta):
	
	if yes == true:
		damage(potata)

func damage(body):
	if visible == true:
		body.change_health_by(-0.5) 

func _on_Area2D_body_entered(body):
	if body.name == "Potata" :
		yes = true
		potata = body


func _on_Area2D_body_exited(body):
	yes = false
