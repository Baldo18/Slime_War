extends Area2D

const speed=300
var velocity = Vector2()
var direction=1

func _ready():
	pass 

func set_ball(dir):
	direction=dir
	if dir ==-1:
		$Sprite.flip_h=true

func _physics_process(delta):
	velocity.x=speed *delta*direction
	translate(velocity)





func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_ball_body_entered(body):
	if "Enemy_slime_red" in body.name:
		body.dead()
	queue_free()
