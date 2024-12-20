extends CharacterBody2D

var ground = true
var speed = 50.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
enum state {CAGE,FLEETING,ANGRY, ATTACKING, JUMP, BACKTOHELL}
var currentState = state.CAGE
var launched = 0
var dieing = false
signal BloodpointsLost
signal BloodpointsGained

var bomba = preload("res://Szenen/HitEffect.tscn")
@onready var player_sound_manager = $EnemySoundManager


func _ready():
	Global.enemies.append(self.get_path())
	$FlyingSprite.play()


func _physics_process(delta):
	
	if dieing == true:
		return
	
	directionFlip()
	
	if currentState == state.CAGE:
		miseryInCage(delta)
	if currentState == state.FLEETING:
		flee(delta)
	if currentState == state.BACKTOHELL:
		highway_to_hell(delta)
	if currentState == state.JUMP:
		launch(delta)
	
	move_and_slide()

func changeState():
	currentState = state.JUMP
	$".".set_collision_mask_value(3,false)
	Global.enemies.erase(self.get_path())
	clean_up_enemies()

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
	change_audio_to()
	change_audio_to("SchreiA")
	$ZombieSprite.visible = false
	$FlyingSprite.visible = true
	$".".set_collision_mask_value(3,true)
	var hitEffect = bomba.instantiate() 
	self.add_child(hitEffect)
	hitEffect.global_position = self.global_position
	currentState = state.BACKTOHELL
	$blood.visible = true 

func highway_to_hell(delta):
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta

	if is_on_floor():
		#ONLY IF IN CAGE!!!!!!!!!!!!!!!!!!!!!!!
		if position.distance_to(get_node(Global.cage).position) < 72:
			Global.enemies.append(self.get_path())
			$ZombieSprite.visible = true
			$FlyingSprite.visible = false
			$blood.visible = false
			launched = 0
			currentState = state.CAGE
		else:
			if launched < 1:
				launched += 1
			else:
				launched = 0
				$ZombieSprite.visible = true
				$FlyingSprite.visible = false
				$blood.visible = false
				currentState = state.FLEETING
		

func directionFlip():
	if velocity.x < 0:
		$ZombieSprite.flip_h = true
	elif velocity.x > 0:
		$ZombieSprite.flip_h = false
		


##counts points for BloodPointsUI
func _on_visible_on_screen_notifier_2d_screen_exited():
	emit_signal("BloodpointsLost")
	Global.bloodpoints = Global.bloodpoints - 10
	queue_free()

func change_audio_to(audio_name: String = ""):
	if audio_name == "":
		player_sound_manager.stop()
	if (audio_name != player_sound_manager["parameters/switch_to_clip"]):
		player_sound_manager.play()
		player_sound_manager["parameters/switch_to_clip"] = audio_name


func getReckt():
	$ZombieSprite.visible = false
	$FlyingSprite.visible = false
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play()
	dieing = true


func die_final() -> void:
	queue_free()

# Function to remove `null` entries or enemies that meet a specific condition
func clean_up_enemies():
	# Iterate backwards through the array to avoid shifting issues
	for i in range(Global.enemies.size() - 1, -1, -1):
		if Global.enemies[i] == null:
			Global.enemies.remove_at(i)
