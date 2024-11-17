extends Node2D

@onready var canfire = true
@onready var timer = $BloodTimer
@onready var texture_progress = $BloodTimerBar
@onready var label = $BloodTimerLabel
@onready var percentage_of_time


func _process(delta):
	if timer.get_time_left() > 0:
		percentage_of_time = ((1-timer.get_time_left()/timer.get_wait_time())*100)
	var use_int = int(percentage_of_time)
	label.text = str(use_int) + "%"
	texture_progress.set_value(timer.get_time_left())  
#func _on_Button_pressed():
	#if canfire:
		#canfire = false
		#$Reload_Timer.start()


func _on_player_kill():
	timer.start()
	print("kill")
