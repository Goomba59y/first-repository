extends KinematicBody2D

var velocity                 = Vector2.ZERO
var potatoSpeed              = 200
var potatoStop               = 0
var attacking                = true
var state                    = IDLE
var pressing                 = false 
var attack_knife             = false
var health                   = 100
var equiped                  = false
var kinfe_fight_style        = 1
var stop                     = false
var can__dash                = true
var dash_distance            = 9999
var dash_delay               = 3
var potata_energy            = 100 
var dash_cost                = 25
var dash_ok                  = true 
var k_m47_max_ammo           = 20
var knife                    = false
var k_m_visable              = false
var visablity                = false
var k_m_ok                   = false
var left                     = false
var right                    = false
var drag                     = false
var food_smad                = 1
var alive                    = true
var slomo                    = false
var can_slomo                = true
var can_dash                 = true
onready var hotbar_1         = $CanvasLayer/quick_inventory
onready var hotbar_2         = $CanvasLayer/quick_inventory2
onready var hotbar_3         = $CanvasLayer/quick_inventory3
onready var hotbar_4         = $CanvasLayer/quick_inventory4
onready var hotbar_5         = $CanvasLayer/quick_inventory5

onready var knife_co  = $area_knife/knife_Coll
onready var knife_par = $kinfe

enum {
	ATTACKING,
	ATTACK_MOVE,
	IDLE,
}

func _ready():
	Cache.set_meta("player", self)
	$CanvasLayer/opacity.modulate = "90ffffff"
	set_process(false)
	


func _process(delta):
	if Input.is_action_just_pressed("left_click"):
		if $K_M47.visible == false:
			food_smad -= 1
	




func _physics_process(delta):
	if Input.is_action_just_pressed("ctrl"):
		if can_slomo == true:
			dash_distance = 99990
			$AudioStreamPlayer2D2.play()
			$Slomo_Timer.start()
			Engine.time_scale = 0.1
	if Input.is_action_just_released("ctrl"):
		if can_slomo == true:
			if potata_energy > dash_cost and $dash_timer.time_left < 1:
				can__dash = true
			dash_distance = 9999
			Engine.time_scale = 1
			$AudioStreamPlayer2D2.stop()
	
	health_checker()
	if $knife.visible == true:
		$ak_chicken_nugget.visible = false
		$K_M47.visible = false
	
	if Input.is_action_just_pressed("2"):
		$K_M47.visible = false
		$ak_chicken_nugget.visible = false
	
	
	if $K_M47.visible == true :
		$ak_chicken_nugget.visible = false
	
	if $ak_chicken_nugget.visible == true :
		$K_M47.visible = false
	
	#ammo
	if $K_M47.visible :
		$CanvasLayer/Label.text = str(int($K_M47.K_M47AMMO))
	elif $ak_chicken_nugget.visible :
		$CanvasLayer/Label.text = str(int($ak_chicken_nugget.ak_chicken_nugget_ammo))
	#dash cooldown
	$CanvasLayer/Label2/Label.text = str(int($dash_timer.time_left))
	
	$CanvasLayer/smad.text = str(int(food_smad))
	
	#something dont let the energy goes below zero
	if potata_energy <= 0:
		potata_energy = 0
	if alive :
		match state:
			IDLE:
				move_potata()
			ATTACKING:
				aTTACKING()
				
			ATTACK_MOVE:
				aTTACK_MOVE()
				

func aTTACKING():
	if attack_knife == true: 
		knife = true
		attack_knife = false
		knife_co.disabled = false
		$kinfe.emitting = true
		$Sprite.play("attack")
		yield($Sprite,"animation_finished")
		$Sprite.play("idel")
		knife_co.disabled = true
		knife = false
		$K_M47.visible = true
		$ak_chicken_nugget.visible = true
		state = IDLE
	
func aTTACK_MOVE():
	if velocity == Vector2.ZERO:
		state = IDLE
	if velocity != Vector2.ZERO:
		if can__dash:
			if potata_energy - dash_cost <= 0:
				dash_ok = false
			if dash_ok != false:
				if potata_energy != 0:
					$dash_particalse.direction = Vector2(clamp(floor(velocity.x), -1, 1), clamp(floor(velocity.y), -1, 1))* dash_distance 
					$dash_particalse.emitting = true
					$CPUParticles2D25.emitting = true
					$CPUParticles2D25/CPUParticles2D26.emitting = true
					$CPUParticles2D25/CPUParticles2D27.emitting = true
					$CPUParticles2D25/CPUParticles2D28.emitting = true
					$CPUParticles2D25/CPUParticles2D29.emitting = true
					print("dsf")
					if (velocity.x < 0 and velocity.x >= (potatoSpeed / 2) * -1) or (velocity.x > 0 and velocity.x <= (potatoSpeed / 2)):
						velocity.x = 0
					if (velocity.y < 0 and velocity.y >= (potatoSpeed / 2) * -1) or (velocity.y > 0 and velocity.y <= (potatoSpeed / 2)):
						velocity.y = 0
					velocity += Vector2(clamp(floor(velocity.x), -1, 1), clamp(floor(velocity.y), -1, 1))* dash_distance 
					can__dash = false
					can_dash  = false
					state = IDLE
					velocity = (move_and_slide(velocity))
					$dash_timer.start(dash_delay)
					
					potata_energy -= dash_cost
		if dash_ok == false:
			state = IDLE
		
	
func move_potata():
	
	
	
	if stop == true :
		$Sprite.play("idel")
		state = 1
	if Input.is_action_just_pressed("right_click") :
		if equiped == true :
			if kinfe_fight_style == 1 :
				$ak_chicken_nugget.visible = false
				$K_M47.visible = false
				attack_knife = true
				yield(get_tree().create_timer(0.1),"timeout")
				state = ATTACKING
			if kinfe_fight_style == 1 :
				$ak_chicken_nugget.visible = false
				$K_M47.visible = false

	if Input.is_action_pressed("up"): 
		$CPUParticles2D25.position.x = -6.371
		$CPUParticles2D25.position.y = 12.867
		$CPUParticles2D25.rotation_degrees = -90
		
		velocity.y = -potatoSpeed
		$Sprite.flip_v = false
		knife_co.position.x = -7.296
		knife_co.position.y = -19
		knife_co.rotation_degrees = 90
		knife_co.scale.y = 1.8
		if not pressing :
			$Sprite.play("up")
			
	
	elif Input.is_action_pressed("down"):
		$CPUParticles2D25.position.x = -6.371
		$CPUParticles2D25.position.y = -7.867
		$CPUParticles2D25.rotation_degrees = 180
		
		velocity.y = potatoSpeed
		knife_co.position.x = -5.5
		knife_co.scale.y = 2
		knife_co.position.y = 30.156
		knife_co.rotation_degrees = 90
	else :
		velocity.y = 0
  
# horizontal
	if Input.is_action_pressed("left"): 
		$CPUParticles2D25.rotation_degrees = 180
		$CPUParticles2D25.position.x       = -25.768
		$knife.position.x = -24.055
		$Sprite.flip_h = true
		$kinfe.position.x = -14
		$kinfe.direction.x = 0.795
		$Sprite.position.x = -13.455
		knife_co.position.y = 3.668
		knife_co.position.x = -33.977
		knife_co.rotation_degrees = 0
		knife_co.scale.y = 1
		velocity.x = -potatoSpeed
		$Sprite.play("move")
		$Sprite.flip_v = false
		pressing = true

	elif Input.is_action_pressed("right"):
		$CPUParticles2D25.rotation_degrees = 0
		$CPUParticles2D25.position.x       = 25.768
		$knife.position.x = 17.055
		velocity.x = potatoSpeed
		$Sprite.flip_h = false
		$kinfe.position.x  = 14
		$kinfe.direction.x = -0.795
		$Sprite.position.x = 0
		knife_co.position.y = 3.668
		knife_co.position.x = 19.323
		knife_co.rotation_degrees = 0
		knife_co.scale.y = 1
		$Sprite.play("move")
		pressing = true
		$Sprite.flip_v = false

	else:
		pressing = false
		velocity.x = 0
	if velocity == Vector2.ZERO :
		$Sprite.play("idel")
		
	velocity = move_and_slide(velocity)
	

	if Input.is_action_just_pressed("dash"):
		if can__dash:
			if velocity != Vector2.ZERO:
				$AudioStreamPlayer2D.play()
				$AudioStreamPlayer2D.volume_db = 20
				state = ATTACK_MOVE
	
func state_changer(value) :
	state = value

func _on_area_knife_body_entered(body) :
	if body.name != "Potata" :
		if knife == true:
			body.change_health_by(-56)
		
	


func _on_dash_timer_timeout():
	if potata_energy > dash_cost :
		
		can__dash = true #maybe
	
	

func change_energy_by(value):
	potata_energy += value
	potata_energy = clamp(potata_energy, 0, 100)

#health changer and checker
func change_health_by(value):
	health_checker()
	health += value

func health_checker():
	if health <= 0:
		$K_M47.alive = false
		$ak_chicken_nugget.alive = false
		alive = false
		$CanvasLayer/VBoxContainer.visible = true
		$CanvasLayer/opacity.visible = true
		$CanvasLayer/VBoxContainer/Button.disabled = false
		$CanvasLayer/VBoxContainer/Button.visible  = true




func _on_Area2D_mouse_entered():
	hotbar_1.play("entered")
	set_process(true)

func _on_Area2D_mouse_exited():
	hotbar_1.play("idle")
	set_process(false)

func _on_Area2D_mouse_entered1():
	hotbar_2.play("entered")
	set_process(true)

func _on_Area2D_mouse_exited1():
	hotbar_2.play("idle")
	set_process(false)

func _on_Area2D_mouse_entered2():
	hotbar_3.play("entered")
	set_process(true)

func _on_Area2D_mouse_exited2():
	hotbar_3.play("idle")
	set_process(false)
	
func _on_Area2D_mouse_entered3():
	hotbar_4.play("entered")
	set_process(true)

func _on_Area2D_mouse_exited3():
	hotbar_4.play("idle")
	set_process(false)

func _on_Area2D_mouse_entered4():
	hotbar_5.play("entered")
	set_process(true)

func _on_Area2D_mouse_exited4():
	hotbar_5.play("idle")
	set_process(false)


func _on_Button_pressed():
	get_tree().reload_current_scene()

func _on_Button_pressed1():
	print("Save Button Pressed...")
	SaveLoad.save_game()

func _on_Button2_pressed():
	print("Load Button Pressed...")
	SaveLoad.load_game()

func save_data():
	Cache.set_meta("player_health", health)
	Cache.set_meta("player_energy", potata_energy)

func load_data():
	health = Cache.data.player_health
	potata_energy = Cache.data.player_energy
	print(str(Cache.data.player_health) + "  " + str(Cache.data.player_energy))


func _on_Slomo_Timer_timeout():
	Engine.time_scale = 1
	$AudioStreamPlayer2D2.stop()
	if potata_energy > dash_cost and $dash_timer.time_left < 1:
		can__dash = true
	can_slomo = false
	dash_distance = 9999
