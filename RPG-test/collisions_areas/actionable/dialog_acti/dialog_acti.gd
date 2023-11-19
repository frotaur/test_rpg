extends Actionable
class_name DialogActi

"""
Dialog actionable. Launches dialog when action is called
"""

@export var dialog : DialogueResource
@export var dialog_start : String = "start"

signal dialog_ended

var am_talking = false

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func action(actioneer : Node2D):
	super(actioneer)
	var ball = DialogState.balloon.instantiate()
	add_child(ball)
	
	DialogState.talking=true
	am_talking = true
	
	ball.start(dialog,dialog_start)

func _on_dialogue_ended(_resource):
	if(am_talking):
		dialog_ended.emit()
		am_talking=false
