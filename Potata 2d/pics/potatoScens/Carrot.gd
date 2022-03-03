extends KinematicBody2D
var Potata = null
var path   = PoolVector2Array()
var speed  = 10
var health = 100
var alive  = true
var motion = Vector2.ZERO
var line = Line2D.new()


func _ready():
	line.width = 1
	line.default_color = Color.green
	get_parent().call_deferred("add_child", line)


func _physics_process(delta):
	print(Potata)
	if Potata != null :
		if Potata.global_position.distance_to(global_position) <= 300:
			$AnimatedSprite.play("stop")
		if Potata.global_position.distance_to(global_position) > 300:
			if !path.empty() :
				motion = global_position.direction_to(path[0]) * speed
				motion = move_and_slide(motion * speed)
				$AnimatedSprite.play("move")
				if global_position.distance_to(path[0]) < 1:
					path.remove(0)
	
	if alive != true :
		queue_free()
	
	$pew_pew_carrot.pew_carrot()
	if Potata != null:
		if Potata.name == "Potata" :
			$pew_pew_carrot.look_at(Potata.global_position)



func _on_Area2D_body_entered(body):
	if body.name == "Potata":
		Potata = body

func change_health_by(value):
	health_checker()
	health += value


func health_checker():
	if health < 0:
		alive = false



func _on_Timer_timeout():
	path = PoolVector2Array()
	if Potata != null :
		Nodes.get_meta("Navi").Navi(self, global_position, Potata.global_position)


func _on_Area2D_body_exited(body):
	Potata = null


func left(body):
	$pew_pew_carrot/AnimatedSprite.flip_v = true
	$pew_pew_carrot.position.x = -8.737
	$AnimatedSprite.flip_h = false


func right(body):
	$pew_pew_carrot/AnimatedSprite.flip_v = false
	$pew_pew_carrot.position.x = 8.737
	$AnimatedSprite.flip_h = true
