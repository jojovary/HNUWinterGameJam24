extends Node2D
@onready var bloodpoints = Global.bloodpoints
var scenes = ["res://Szenen/PrototypeLevelMartin.tscn", "res://Szenen/PrototypeLevelMartin3.tscn"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$HighscoreLabel.text = str(bloodpoints) + " POINTS"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_pressed():
	Global.current_level = Global.current_level +1
	if Global.current_level == 1:
		get_tree().change_scene_to_file("res://Szenen/Level/Level01Final.tscn")
	if Global.current_level == 2:
		get_tree().change_scene_to_file("res://Szenen/Level/Level02Final.tscn")
	if Global.current_level == 3:
		get_tree().change_scene_to_file("res://Szenen/Level/Level03Final.tscn")
	if Global.current_level == 4:
		get_tree().change_scene_to_file("res://Szenen/Level/Level04Final.tscn")
	if Global.current_level == 5:
		get_tree().change_scene_to_file("res://Szenen/Level/Level05Final.tscn")
	if Global.current_level == 6:
		get_tree().change_scene_to_file("res://Szenen/Level/Level06Final.tscn")
	if Global.current_level == 7:
		get_tree().change_scene_to_file("res://Szenen/Level/Level07Final.tscn")
	if Global.current_level == 8:
		get_tree().change_scene_to_file("res://Szenen/Level/Level08Final.tscn")
	if Global.current_level == 9:
		#get_tree().change_scene_to_file()
		pass
	
	
	
	
