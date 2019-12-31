extends KinematicBody2D

export var GRAVITY = 50
export var MAX_FALL_SPEED = 1000
export var JUMP_FORCE = 500
export var Y_Velocity = 0

var speed = 250
var X_Velocity = Vector2()


func handle_key_released():
	if Input.is_action_just_released("move_right"):
		$AnimationPlayer.play("Idle_No_Weapons")
		
	if Input.is_action_just_released("move_left"):
		$AnimationPlayer.play("Idle_No_Weapons")
	
	if Input.is_action_just_released("jump"):
		$AnimationPlayer.play("Idle_No_Weapons")
	
	if Input.is_action_just_released("crouch"):
		$AnimationPlayer.play("Idle_No_Weapons")
		

func _physics_process(delta):
	# Detect up/down/left/right keystate and only move when pressed.
	X_Velocity = Vector2()
	
	if Input.is_action_pressed('move_right'):
#		$Sprite.set_flip_h(false)
		$AnimationPlayer.play("run_no_weapons")
		X_Velocity.x += 1
		
	if Input.is_action_pressed('move_left'):
#		$Sprite.set_flip_h(true)
		$AnimationPlayer.play("run_no_weapons")
		X_Velocity.x -= 1
	move_and_slide(Vector2(X_Velocity.x * speed, Y_Velocity), Vector2(0,-1))

	if Input.is_action_pressed('crouch'):
		$AnimationPlayer.play("crouch_no_weapons")
#		X_Velocity.y += 1
#	if Input.is_action_just_pressed('jump'):
#		$AnimationPlayer.play("jump_no_weapons")
#		Y_Velocity = -JUMP_FORCE
	
	handle_key_released()
	
	var grounded = is_on_floor()
	Y_Velocity += GRAVITY
	if grounded and Input.is_action_just_pressed('jump'):
		$AnimationPlayer.play("jump_no_weapons")
		Y_Velocity = -JUMP_FORCE
	if grounded and Y_Velocity >= 5:
		Y_Velocity = 5
	if Y_Velocity > MAX_FALL_SPEED:
		Y_Velocity = MAX_FALL_SPEED
		
	if grounded:
		var mouse_pos = get_global_mouse_position();
		var mouse_x = mouse_pos.x
		
		if X_Velocity.x == 0:
			if mouse_x > self.position.x:
				$Sprite.set_flip_h(false)
			if mouse_x < self.position.x:
				$Sprite.set_flip_h(true)
			$AnimationPlayer.play("Idle_No_Weapons")
		else:
			if mouse_x > self.position.x and Input.is_action_pressed("move_left"):
				$AnimationPlayer.play_backwards("run_no_weapons")
			if mouse_x < self.position.x and Input.is_action_pressed("move_right"):
				$AnimationPlayer.play_backwards("run_no_weapons")
#			$AnimationPlayer.play("run_no_weapons")
	else:
		$AnimationPlayer.play("jump_no_weapons")