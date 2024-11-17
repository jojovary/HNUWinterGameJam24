extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.back_to_hell()
		print("Whack")
