extends CharacterBody2D
var ground = true
var speed = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum state {CAGE,FLEETING,ANGRY, ATTACKING, JUMP, BACKTOHELL}
var currentState = state.CAGE
var launched = false
signal BloodpointsLost
signal BloodpointsGained
 
func _ready():
	Global.enemies.append(self.get_path())
	$FlyingSprite.play("fly")


func _physics_process(delta):
	directionFlip()
	
	if currentState == state.CAGE:
		miseryInCage(delta)
	elif currentState == state.FLEETING:
		flee(delta)
	elif currentState == state.JUMP:
		launch(delta)
	elif currentState == state.BACKTOHELL:
		highway_to_hell(delta)
	
	
	move_and_slide()

func changeState():
	currentState = state.JUMP
	launched = false
	$".".set_collision_mask_value(3,false)
	Global.enemies.erase(self.get_path())

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

func launch(delta):
	
	if launched == false:
			velocity.y = randf_range(-400,-700 )
			velocity.x = randf_range(-100,-200)
			launched = true
	 # while the player is jumping gravity should affect him
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	directionFlip()
		#enables the player to jump while he is not in the air and pressing the according button
	if is_on_floor():
		currentState = state.FLEETING

func back_to_hell():
	currentState = state.BACKTOHELL
	launched = false
	$ZombieSprite.visible = false
	$FlyingSprite.visible = true
	$".".set_collision_mask_value(3,true)
	Global.enemies.append(self.get_path())



func highway_to_hell(delta):
	 # while the player is jumping gravity should affect him
	if launched == false:
			velocity.y = -600
			velocity.x = Global.cage_speed + 150
			launched = true
	
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	
	directionFlip()
		#enables the player to jump while he is not in the air and pressing the according button
	if is_on_floor():
		currentState = state.CAGE
		$ZombieSprite.visible = true
		$FlyingSprite.visible = false
		



func directionFlip():
	if velocity.x < 0:
		$ZombieSprite.flip_h = true
	elif velocity.x > 0:
		$ZombieSprite.flip_h = false
		


##counts points for BloodPointsUI
func _on_visible_on_screen_notifier_2d_screen_exited():
	emit_signal("BloodpointsLost")
	Global.bloodpoints = Global.bloodpoints - 10
	print(Global.bloodpoints)
	queue_free()
