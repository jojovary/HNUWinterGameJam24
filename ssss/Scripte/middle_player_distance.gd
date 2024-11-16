extends Marker2D
var offset = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	middleplayer_vector()
	middlebackground_vector()
func middleplayer_vector():
	#print ($"../Player".position - $".".position)
	offset = $"../Player".position - $".".position
	#print (str(offset.y) + " + " + str(offset.x))
func middlebackground_vector():
	$"../MovingBackground".position = offset * -0.03
	$"../BGMountainBlack".position = offset * -0.07
	$"../BGMountainGray".position = offset * -0.11
	$"../BGMountainGrey".position = offset * -0.15
	$"../BGGrey".position = offset * -0.19
