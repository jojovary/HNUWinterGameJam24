extends Node

# Timer variables
var time_passed: float = 0.0
var wait_time: float = 0.0
var enemies = []
var cage 
var gamefinished = 0
var cage_speed = 0
var bloodpoints = 230

# Called when the node enters the scene tree for the first time.
func _ready():
	# Set the initial random wait time between 2 and 5 seconds
	wait_time = randf_range(1.0, 2.0)

# Called every frame. Delta is the elapsed time since the last frame.
func _process(delta: float):
	#print(bloodpoints)
	##gameover check
	_game_over()
	# Accumulate the time passed
	time_passed += delta
	
	# Check if the wait time has passed
	if time_passed >= wait_time:
		# release human
		if enemies.size() > 0:
			#print(enemies[randi_range(0,enemies.size()-1)])
			var enemy = get_node(enemies[randi_range(0,enemies.size()-1)])
			var cager = get_node(cage)
			if enemy != null:
				enemy.changeState()
			if cager != null:
				cager.increaseSpeed()
			
		# Reset the time and choose a new random wait time
		time_passed = 0.0
		wait_time = randf_range(1.0, 2.0)
		
func _game_over():
	if bloodpoints == 0:
		get_tree().change_scene_to_file("res://Szenen/death_screen.tscn")
