extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$TitelAnimation.play("TitleAnimation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_start_pressed():
	get_tree().change_scene_to_file("res://Szenen/Steuerung.tscn")


func _on_button_quit_pressed():
	get_tree().quit()
