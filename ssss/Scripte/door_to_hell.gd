extends Area2D

var bloodspltter = preload("res://Szenen/bloodsplatter_side_flipped.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		$bloodspawn.blood()
