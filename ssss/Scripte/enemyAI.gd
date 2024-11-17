extends CharacterBody2D
var ground = true
var speed = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum state {CAGE,FLEETING,ANGRY, ATTACKING, JUMP, BACKTOHELL}
var currentState = state.CAGE

func _ready():
	Global.enemies.append(self.get_path())
	$FlyingSprite.play("fly")


func _physics_process(delta):
	
	
	if currentState == state.CAGE:
		miseryInCage(delta)
	
	if currentState == state.FLEETING:
		flee(delta)
	
	if currentState == state.JUMP:
		launch(delta)
	
	if currentState == state.BACKTOHELL:
		highway_to_hell(delta)
	
	directionFlip()
	move_and_slide()



func flee(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		speed = speed
		scale.x = -1
		
	velocity.x = abs(speed) * -1

func miseryInCage(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if !$GroundDetectorRight.is_colliding():
		speed = speed * -1
		scale.x = abs(scale.x) * -1
	
	velocity.x = speed

func changeState():
	$".".set_collision_mask_value(3,false)
	Global.enemies.erase(self.get_path())
	$ZombieSprite.visible = true
	$FlyingSprite.visible = false
	velocity.y = randf_range(-400,-700 )
	velocity.x = randf_range(-100,-200)
	currentState = state.JUMP

func launch(delta):
	 # while the player is jumping gravity should affect him
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	directionFlip()
		#enables the player to jump while he is not in the air and pressing the according button
	if is_on_floor():
		$ZombieSprite.visible = true
		$FlyingSprite.visible = false
		currentState = state.FLEETING

func back_to_hell():
	velocity.y = -600
	velocity.x = Global.cage_speed + 150
	$ZombieSprite.visible = false
	$FlyingSprite.visible = true
	$".".set_collision_mask_value(3,true)
	currentState = state.BACKTOHELL

func highway_to_hell(delta):
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	directionFlip()
		#enables the player to jump while he is not in the air and pressing the according button
	if is_on_floor():
		#ONLY IF IN CAGE!!!!!!!!!!!!!!!!!!!!!!!
		currentState = state.CAGE
		Global.enemies.append(self.get_path())
		$ZombieSprite.visible = true
		$FlyingSprite.visible = false
		



func directionFlip():
	if velocity.x < 0:
		$ZombieSprite.flip_h = true
	elif velocity.x > 0:
		$ZombieSprite.flip_h = false
