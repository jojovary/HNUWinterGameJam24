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
	offset = $"../../Player".position - $".".position
	#print (str(offset.y) + " + " + str(offset.x))
func middlebackground_vector():
	$"../MovingBackground".position = offset * -0.02
	$"../BGMountainBlack".position = offset * -0.04
	$"../BGMountainGray".position = offset * -0.08
	$"../BGMountainGrey".position = offset * -0.16
	$"../BGGrey".position = offset * -0.19
