extends Node2D

func _input(event):
	if(event.is_action_pressed('test')):
		CameraController.zoom = randi_range(1,8)
