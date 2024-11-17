extends CPUParticles2D


func _on_timer_timeout() -> void:
	queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
