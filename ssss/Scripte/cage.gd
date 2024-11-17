extends AnimatableBody2D

var direction = Vector2(50,0)
const peopleWeight = 4



func _ready() -> void:
	Global.cage = self.get_path()
	Global.cage_speed

func _physics_process(delta: float) -> void:
	if position.x < 6120:
		$".".position +=  direction * delta
	else:
		get_tree().change_scene_to_file("res://Szenen/endlevel_screen.tscn")

func increaseSpeed():
	direction.x += peopleWeight
	Global.cage_speed = direction.x

func decreaseSpeed():
	direction.x -= peopleWeight
	Global.cage_speed = direction.x
