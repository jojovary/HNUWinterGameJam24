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
		clean_up_enemies()
		#print(Global.enemies)
		Global.bloodpoints = Global.bloodpoints - 5
		body.getReckt()
		#body.queue_free()		##funktioniert nicht wegen Change State
		#print("SLASH!" + str(body))

# Function to remove `null` entries or enemies that meet a specific condition
func clean_up_enemies():
	# Iterate backwards through the array to avoid shifting issues
	for i in range(Global.enemies.size() - 1, -1, -1):
		if Global.enemies[i] == null:
			Global.enemies.remove_at(i)
