extends Marker2D
var offset = 0
var mouse_position = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	middlemouse_vector()
	middlebackground_vector()
func middlemouse_vector():
	#print ($"../Player".position - $".".position)
	if typeof(mouse_position) != TYPE_INT:
		offset = mouse_position - $".".position
	#print (str(offset.y) + " + " + str(offset.x))
func middlebackground_vector():
	if typeof(mouse_position) != TYPE_INT:
		$"../ParallaxAtHome/MovingBackground".position = offset * -0.02
		$"../ParallaxAtHome/BGMountainBlack".position = offset * -0.04
		$"../ParallaxAtHome/BGMountainGray".position = offset * -0.08
		$"../ParallaxAtHome/BGMountainGrey".position = offset * -0.16
		$"../ParallaxAtHome/BGGrey".position = offset * -0.19

#func _input(event):
	##if you press the mouse button and your mouse is inside of your area the the player moves
	#if event.is_action_pressed("Dash"):
		#player_target = get_local_mouse_position()		

func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		pass
	if event is InputEventMouseMotion:
		print("Mouse Motion at: ", event.position)
		mouse_position = event.position
		#Print the size of the viewport.
		print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)
	
func mouseplayer_vector():
	print (mouse_position.position - $".".position)
	
	#offset_dash = $CollisionShape2D.position - mouse_position
	
	
