extends Node2D
var kinfe_fight_style = 1
var knife             = false 

func _ready():
	visible = false

func _physics_process(delta):
	if Input.is_action_just_pressed("right_click") :
		if knife == false:
			if kinfe_fight_style == 1 :
				$AudioStreamPlayer2D.play()
				visible = true
				knife = true
				$Area2D/CollisionShape2D.disabled = false
				$AnimatedSprite.play("attack")
				yield($AnimatedSprite,"animation_finished")
				knife = false
				$AnimatedSprite.play("poop")
				visible = false
				$Area2D/CollisionShape2D.disabled = true
	if Input.is_action_pressed("up"):
		position.x = -3.945
		rotation_degrees = -90
		position.y = -9.172
		
	if Input.is_action_pressed("down"):
		position.x = -5.945
		rotation_degrees = 90
		position.y = 13.828
	
	if Input.is_action_pressed("left"):
		$Area2D/CollisionShape2D.position.x = -6.75
		$AnimatedSprite.flip_h = true
		position.y = 2.828
		rotation_degrees = 0
	if Input.is_action_pressed("right"):
		$Area2D/CollisionShape2D.position.x = 6.75
		$AnimatedSprite.flip_h = false
		position.y = 2.828
		rotation_degrees = 0

func _on_Area2D_body_entered(body):
	body.change_health_by(-25)
