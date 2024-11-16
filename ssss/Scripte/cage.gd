extends AnimatableBody2D

var direction = Vector2(50,0)

func _physics_process(delta: float) -> void:
	$".".position +=  direction * delta
