extends Node2D


@export var resource: DialogueResource


func _ready():
	"""
	Basic necessary things to call the function.
	Portrait and color are contained directly in the DialogState dict
	"""
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	var ball = DialogState.balloon.instantiate()
	add_child(ball)
	ball.start(resource, 'nigga')


### Signals
func _on_dialogue_ended(_resource: DialogueResource):
	get_tree().quit()
