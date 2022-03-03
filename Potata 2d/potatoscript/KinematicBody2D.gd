extends KinematicBody2D

var velocity    = Vector2.ZERO
var potatoSpeed = 200
var potatoStop  = 0
var attacking   = false
var state = IDLE
enum {
	ATTACKING,
	ATTACK_MOVE,
	IDLE
}

func _physics_process(_delta):
  # vertical
	match state :
		IDLE :
			print("tkbeer allah akbr , booom")
		ATTACKING :
			print("we lost too many lives to write this code")
		ATTACK_MOVE :
			print("i lost my father , my family, my friends just to write this code .......... was it worth it? ")

	if Input.is_key_pressed(KEY_W): 
		velocity.y = -potatoSpeed
	elif Input.is_key_pressed(KEY_S):
		velocity.y = potatoSpeed
	else :
		velocity.y = 0
  # horizontal
	if Input.is_key_pressed(KEY_A): 
		$Sprite.flip_h = true #maybe
		$kinfe.position.x = -14
		$kinfe.direction.x = 0.795
		velocity.x = -potatoSpeed
	elif Input.is_key_pressed(KEY_D): 
		velocity.x = potatoSpeed
		$Sprite.flip_h = false
		$kinfe.position.x = 14
		$kinfe.direction.x = -0.795
	else :
		velocity.x = 0
		
	if attacking == false :
		velocity = move_and_slide(velocity)
		
		
	if Input.is_action_just_pressed("right_click"):
		attacking = true
		$Sprite.play("attack")
		$kinfe.emitting = true
		yield($Sprite,"animation_finished")
		attacking = false
			
			
	if velocity != Vector2(0,0):
		$Sprite.play("attack move")
	else :
		if attacking == true :
			$Sprite.play("attack")
		else :
			$Sprite.play("idel")
			
