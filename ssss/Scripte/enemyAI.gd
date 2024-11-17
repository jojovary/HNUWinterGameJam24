extends CharacterBody2D

var ground = true
var speed = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum state {CAGE,FLEETING,ANGRY, ATTACKING, JUMP, BACKTOHELL}
var currentState = state.CAGE
var launched = 0

func _ready():
	Global.enemies.append(self.get_path())
	$FlyingSprite.play()


func _physics_process(delta):
	directionFlip()
	
	if currentState == state.CAGE:
		miseryInCage(delta)
	if currentState == state.FLEETING:
		flee(delta)
	if currentState == state.BACKTOHELL:
		highway_to_hell(delta)
	if currentState == state.JUMP:
		launch(delta)
	
	print(currentState)
	
	move_and_slide()

func changeState():
	currentState = state.JUMP
	$".".set_collision_mask_value(3,false)
	Global.enemies.erase(self.get_path())

func flee(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		speed = speed
		scale.x = -1
	velocity.x = abs(speed) * -1
	$".".set_collision_mask_value(3,false)

func miseryInCage(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if !$GroundDetectorRight.is_colliding():
		speed = speed * -1
		scale.x = abs(scale.x) * -1
	velocity.x = speed

func launch(delta):
	# while the player is jumping gravity should affect him
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	directionFlip()
	#enables the player to jump while he is not in the air and pressing the according button
	if is_on_floor():
		
		if launched < 1:
			velocity.y = randf_range(-400,-700 )
			velocity.x = randf_range(-100,-200)
			launched += 1
		else:
			launched = 0
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

	if is_on_floor():
		#ONLY IF IN CAGE!!!!!!!!!!!!!!!!!!!!!!!
		if position.distance_to(get_node(Global.cage).position) < 72:
			Global.enemies.append(self.get_path())
			$ZombieSprite.visible = true
			$FlyingSprite.visible = false
			launched = 0
			currentState = state.CAGE
		else:
			if launched < 1:
				launched += 1
			else:
				launched = 0
				$ZombieSprite.visible = true
				$FlyingSprite.visible = false
				currentState = state.FLEETING
		

func directionFlip():
	if velocity.x < 0:
		$ZombieSprite.flip_h = true
	elif velocity.x > 0:
		$ZombieSprite.flip_h = false
