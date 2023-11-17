extends Actionable
class_name DialogActi

"""
Dialog actionable. Launches dialog when action is called
"""

@export var dialog : DialogueResource
@export var dialog_start : String = "start"


func action():
	var ball = DialogState.balloon.instantiate()
	add_child(ball)
	
	ball.start(dialog,dialog_start)

