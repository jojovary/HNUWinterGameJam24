extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.playerInEatingRange = true
		Global.enemyInRange = self

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Global.playerInEatingRange = false
		Global.enemyInRange = null
