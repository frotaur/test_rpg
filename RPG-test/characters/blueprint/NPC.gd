extends CharacterBody2D

"""
Actionable dialog class. 
Give it a dialog resource, and the start of the dialog.
Shape the collisionShape, and boom, dialog.
"""

@export var dialog : DialogueResource
@export var dialog_start : String = "start"

@export var the_name : String # Used for assigning dialogs
@export var portrait : Texture2D # Used for assigning dialogs
@export var color : Color = Color(0.3,0.3,0.3) # Used for dialogs, typical character color

@onready var dialog_actionable : DialogActi = %DialogActi

func _ready():
	dialog_actionable.dialog = dialog
	dialog_actionable.dialog_start = dialog_start
	
	# Make sure the balloon data exists in singleton
	DialogState.add_character(the_name,portrait,color)

func _input(event):
	if(Input.is_key_pressed(KEY_K)):
		dialog_actionable.action()
