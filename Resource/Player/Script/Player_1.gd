extends KinematicBody2D

const ball=preload("res://Resource/Attack/ball.tscn")
const ACCELERATION = 70
const MAX_SPEED = 200 
const JUMP_H = -700
const UP = Vector2(0, -1)
const gravity = 40

var velocity=Vector2()
var direction=1
var motion = Vector2()
var is_attacking=false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	# apply gravity to the player
	motion.y += gravity
	var friction = false
	
	#Este if sirve para ir hacia la derecha
	if Input.is_action_pressed("ui_right"):
		if is_attacking==false:
			$AnimatedSprite.flip_h=false
			$AnimatedSprite.play("Walk")
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			if sign($Position2D.position.x)==-1:
				$Position2D.position.x *=-1
				
	#Este elif sirve para ir a la izquierda
	elif Input.is_action_pressed("ui_left"):
		if is_attacking==false:
			$AnimatedSprite.flip_h=true
			$AnimatedSprite.play("Walk")
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			if sign($Position2D.position.x)==1:
				$Position2D.position.x *=-1
		
	#este else es para cuando el personaje este quieto	
	else:
		if is_attacking==false:
			$AnimatedSprite.play("Idle")
			friction = true
		 
	#Este sirve para el primer ataque "bola de slime"
	if Input.is_action_just_pressed("Attack_1") and is_attacking==false:
		is_attacking=true
		$AnimatedSprite.play("Attack_1")
		var BALL=ball.instance()
		if sign($Position2D.position.x)== 1:
			BALL.set_ball(1)
		else:
			BALL.set_ball(-1)
		get_parent().add_child(BALL)
		BALL.position= $Position2D.global_position
		
		
	
	#Este para el salto
	if is_on_floor():
 
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
 
	motion = move_and_slide(motion, UP)



func _on_AnimatedSprite_animation_finished():
	is_attacking=false
