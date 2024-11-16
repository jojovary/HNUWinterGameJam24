extends CharacterBody2D

var player_target = Vector2()
var offset_dash = 0
var mouse_position = 0
var dash_speed = 10


const SPEED = 500.0
const DECELARATION = 5.0
const ACCELERATION = 5.0
const JUMP_VELOCITY = -400.0
var jump_count = 0
const max_jump_count = 3
var current_direction = 0

func _physics_process(delta: float) -> void:
	#dash()
	jump(delta)
	accelerate()
	#changeDirection()
	move_and_slide()
	#mouseplayer_vector()
	
func _ready():
	player_target =  $".".position


func jump(delta):
	 # while the player is jumping gravity should affect him
	if not is_on_floor():
		velocity.y += ProjectSettings.get_setting("physics/2d/default_gravity") * delta
	if is_on_floor():
		jump_count = 0
		#enables the player to jump while he is not in the air and pressing the according button
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jump_count:
			velocity.y = JUMP_VELOCITY
			jump_count += 1

func accelerate():
	if Input.is_action_pressed("ui_left"):
		current_direction = -1
	
	if Input.is_action_pressed("ui_right"):
		current_direction = 1
	
	velocity.x = abs(velocity.x) * current_direction
	
	if current_direction == 1:
		velocity.x = move_toward(velocity.x, SPEED, ACCELERATION)
	elif current_direction == -1:
		velocity.x = move_toward(velocity.x, -SPEED, ACCELERATION)



func muell():
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if  direction:
		velocity.x = move_toward(velocity.x, SPEED * direction, ACCELERATION ) 
	else:
		velocity.x = move_toward(velocity.x, 0, DECELARATION)
		
#func _input(event):
	##if you press the mouse button and your mouse is inside of your area the the player moves
	#if event.is_action_pressed("Dash"):
		#player_target = get_local_mouse_position()		
		#
##func _input(event):
	### Mouse in viewport coordinates.
	###if event is InputEventMouseButton:
		###print("Mouse Click/Unclick at: ", event.position)
		###pass
	##if event is InputEventMouseMotion:
		###print("Mouse Motion at: ", event.position)
		##mouse_position = event.position
	### Print the size of the viewport.
	###print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
	##
##func mouseplayer_vector():
	###print ($"../Player".position - $".".position)
	##
	##offset_dash = $CollisionShape2D.position - mouse_position
	##
	##
#func dash():
	#if Input.is_action_just_pressed("Dash"):
		#velocity = velocity. lerp(player_target * 1, dash_speed) 
		#move_and_slide()
			#
