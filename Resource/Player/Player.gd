extends KinematicBody2D


const ACCELERATION = 70
const MAX_SPEED = 300
const JUMP_H = -700
const UP = Vector2(0, -1)
const gravity = 40
const ball=preload("res://Resource/Attack/ball.tscn")

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var Fire_delay :=$Fire_timer

var FireDelay: float=0.5
var motion = Vector2()

func _physics_process(delta):
	# apply gravity to the player
	motion.y += gravity
	var friction = false
 
	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		animationPlayer.play("Walk")
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		
		if sign($Position2D.position.x)==-1:
			$Position2D.position.x *=-1
		
	elif Input.is_action_pressed("ui_left"):
		animationPlayer.play("Walk")
		sprite.flip_h = true
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		if sign($Position2D.position.x)==1:
			$Position2D.position.x *=-1
	
	else:
		animationPlayer.play("Idle")
		friction = true
		
	if Input.is_action_pressed("Attack_1") and Fire_delay.is_stopped():
		animationPlayer.play("Attack_1")
		Fire_delay.start(FireDelay)
		var BALL=ball.instance()
		if sign($Position2D.position.x)== 1:
			BALL.set_ball(1)
		else:
			BALL.set_ball(-1)
		get_parent().add_child(BALL)
		BALL.position= $Position2D.global_position
		
		
	
	
	if is_on_floor():
 
		if Input.is_action_just_pressed("ui_accept"):
			motion.y = JUMP_H
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.5)
	else:
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.01)
 
	motion = move_and_slide(motion, UP)
	
	
	
