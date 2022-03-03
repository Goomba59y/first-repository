extends Node
var health = 100



func health_checker() :
	if health > 0 :
		$Sprite.play("ALIVE")
	else :
		$Sprite.play("ded")
		yield($Sprite,"animation_finished")
		
		queue_free()

func change_health_by(value):
	health += value
	health_checker()
	
