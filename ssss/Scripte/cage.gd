extends AnimatableBody2D

var direction = Vector2(50,0)
const peopleWeight = 5

func _ready() -> void:
	Global.cage = self.get_path()

func _physics_process(delta: float) -> void:
	print(self.get_path())
	
	$".".position +=  direction * delta

func increaseSpeed():
	direction.x += peopleWeight

func decreaseSpeed():
	direction.x -= peopleWeight
