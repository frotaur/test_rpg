extends CharacterBody2D

"""
Actionable dialog class. 
Give it a dialog resource, and the start of the dialog.
Shape the collisionShape, and boom, dialog.
"""

@export var dialog : DialogueResource
@export var dialog_start : String = "start"

func action():
	var balloon= DialogState.balloon.instantiate()
	
	add_child(ball)
	
	ball.start(dialog,dialog_start)
