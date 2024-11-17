extends Node2D
@onready var bloodpoints = Global.bloodpoints


# Called when the node enters the scene tree for the first time.
func _ready():
	$HighscoreLabel.text = str(bloodpoints)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
