extends Node2D
var bloodsplatter = preload("res://Szenen/bloodsplatter_side_flipped.tscn")
var bloodsplatter2 = preload("res://Szenen/bloodsplater_up_flipped.tscn")
var muzzlePositions = []


# adds the muzzlePositions into the array
func _ready():
	for i in get_children():
		muzzlePositions.append(i)

# handle inputs
func blood():
	for i in muzzlePositions:
		var rando = randi_range(0,3)
		if rando < 3:
			var blood = bloodsplatter.instantiate()
			add_child(blood)
			get_tree().current_scene.add_child(blood)
			i.global_position.y =  i.global_position.y + randf_range(-1,3)
			blood.global_position = i.global_position
		else:
			var blood = bloodsplatter2.instantiate()
			add_child(blood)
			get_tree().current_scene.add_child(blood)
			i.global_position.y =  i.global_position.y + randf_range(-2,2)
			blood.global_position = i.global_position
		
