extends KinematicBody2D

const ACCELERATION = 70
const MAX_SPEED = 200 
const JUMP_H = -700
const UP = Vector2(0, -1)
const gravity = 50

var velocity=Vector2()
var direction=1


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	velocity.x=MAX_SPEED* direction
	
	if direction==1:
		$AnimatedSprite.flip_h=false
	else:
		$AnimatedSprite.flip_h=true
	
	$AnimatedSprite.play("Walk")
	velocity.y=gravity
	velocity=move_and_slide(velocity, UP)
	
	if is_on_wall():
		direction=direction* -1
