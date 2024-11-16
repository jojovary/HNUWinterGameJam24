extends CharacterBody2D


const SPEED = 200.0
const DECELERATION = 5.0
const JUMP_VELOCITY = -400.0
var facing = 1
var whip_attack_anim = false
var slash_attack_anim


func _ready():
	$WhipSprite.hide()
	$SlashSprite.hide()





func _physics_process(delta: float) -> void:
	_movement()
	_attacks()
	_animation_check()
	#_hitboxes()
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if velocity.x < 0:
		$PlayerSpriteMovement.flip_h = true
		$WhipSprite.flip_h = true
		$SlashSprite.flip_h = true	
	elif velocity.x > 0:
		$PlayerSpriteMovement.flip_h = false
		$WhipSprite.flip_h = false
		$SlashSprite.flip_h = false
		

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION)
	

	
	move_and_slide()
func _animation_check():
	if slash_attack_anim == true:
		$PlayerSpriteMovement.hide()
		$WhipSprite.hide()
		$SlashSprite.show()
	elif whip_attack_anim:
		$PlayerSpriteMovement.hide()
		$WhipSprite.show()
		$SlashSprite.hide()
	elif !slash_attack_anim:
		$PlayerSpriteMovement.show()
		$WhipSprite.hide()
		$SlashSprite.hide()
	elif !whip_attack_anim:
		$PlayerSpriteMovement.show()
		$WhipSprite.hide()
		$SlashSprite.hide()
		
		
func _attacks():
	if Input.is_action_just_pressed("Whip"):
		$PlayerAnimationAttackWhip.play("Whip")
		whip_attack_anim = true
		
	if Input.is_action_just_pressed("Slash"):	
		$PlayerAnimationAttackSlash.play("Slash")
		slash_attack_anim = true
	
func _movement():
		if Input.is_action_just_pressed("ui_left") or 	Input.is_action_just_pressed("ui_right") or is_on_floor():
			$PlayerSpriteMovement.play("Walk")
		if  not is_on_floor() and slash_attack_anim == false and whip_attack_anim == false:
			$PlayerSpriteMovement.play("Jump")
			
#func _hitboxes():
	#$PlayerSpriteAttack.get_frame()

#func _on_player_sprite_attack_animation_finished():
	#attack_animation = false
#
#
#func _on_player_sprite_attack_frame_changed():
	#attack_animation = true




func _on_player_animation_attack_whip_animation_finished(Whip):
	whip_attack_anim = false

func _on_player_animation_attack_slash_animation_finished(Slash):
	slash_attack_anim = false
