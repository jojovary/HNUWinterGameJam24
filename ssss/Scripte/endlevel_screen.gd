extends Node2D
@onready var bloodpoints = Global.bloodpoints
var scenes = ["res://Szenen/PrototypeLevelMartin.tscn", "res://Szenen/PrototypeLevelMartin3.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$HighscoreLabel.text = str(bloodpoints) + " POINTS"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
