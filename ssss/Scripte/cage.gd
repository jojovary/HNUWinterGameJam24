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
		pass

func increaseSpeed():
	direction.x += peopleWeight
	Global.cage_speed = direction.x

func decreaseSpeed():
	direction.x -= peopleWeight
	Global.cage_speed = direction.x
