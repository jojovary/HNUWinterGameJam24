extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D0.play()
	$AnimatedSprite2D2.play()
	$AnimatedSprite2D3.play()
	$AnimatedSprite2D4.play()  



func _on_texture_button_button_down() -> void:
	get_tree().change_scene_to_file("res://Szenen/Level/Tutorial.tscn")
