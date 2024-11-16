extends CharacterBody2D
var ground = true

var speed = 50.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_right = true

enum state {CAGE,FLEETING,ANGRY, ATTACKING}
var currentState = state.CAGE

func _physics_process(delta):
	if currentState == state.CAGE:
		miseryInCage(delta)
	move_and_slide()


func miseryInCage(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	#if $GroundDetectorLeft.is_colliding():
		#speed = speed * -1
		#print("test")
		##scale.x = abs(scale.x) * -1
		
	if !$GroundDetectorRight.is_colliding():
		print("ich collide gerade nicht")
		speed = speed * -1
		scale.x = abs(scale.x) * -1
		
	velocity.x = speed
