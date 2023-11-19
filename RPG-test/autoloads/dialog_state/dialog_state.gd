extends Node

"""
Autoload. Carries all the dialog information.
To be seen in what format, but probably with dictionaries
containing the variables related to different NPCS (according 
to the dialog choices you made)
"""

var balloon = preload("res://UI/dialog_box.tscn")
var example_balloon = preload("res://addons/dialogue_manager/example_balloon/example_balloon.tscn")

var talking = false # Set true when dialog starts, prevent other inputs

var box_style = {
	'king' : {'portrait' : preload("res://art/characters/NPC/King.png"), 'color' : Color(0.5,0.3,0.3)}
}

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_end)
	
func add_character(the_name:String,portrait:Texture2D, color:Color):
	box_style[the_name.to_lower()]= {'portrait':portrait,'color':color}
	
func _on_dialogue_end(resource):
	talking=false
