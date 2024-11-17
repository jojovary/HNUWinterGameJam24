extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		Global.enemies.erase(body.get_path())		##funktioniert, solange man den Cage nicht angreift
		Global.enemies.resize(Global.enemies.size() - 1)
		#print(Global.enemies)
		Global.bloodpoints = Global.bloodpoints - 5
		body.queue_free()		##funktioniert nicht wegen Change State
		print("SLASH!" + str(body))
		
