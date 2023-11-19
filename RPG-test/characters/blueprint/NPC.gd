extends CharacterBody2D
class_name Npc

"""
	Base class for NPC's.
	Needs :
		A sprite texture. Haven't decided on the structure yet, 
		but probably 16*16 4*3 walk animations, in order s-w-e-n. 
		If I add idle animation also, will have to modify.
	
	Optional Args:
		Can add a *dialog* resource, then the NPC can be talked to.
		In that case, must also include *the_name* (dialog npc name)
		and the *portrait* for dialog of the npc. Optionally, also
		the *color* to style de balloon.
	
		Can add a 'wander-radius'. If defined, the npc will wander randomly
		within that radius. 
		
		For now, it always at least has the stopped state where it looks around. 
		
"""

@export var dialog : DialogueResource
@export var dialog_start : String = "start"

@export var the_name : String # Used for assigning dialogs
@export var portrait : Texture2D # Used for assigning dialogs
@export var color : Color = Color(0.3,0.3,0.3) # Used for dialogs, typical character color

@export var sprite_texture : Texture2D 

@export var wander_radius : float = 0.
 
@onready var dialog_actionable : DialogActi = %DialogActi
@onready var anitree : AnimationTree = $AnimationTree
@onready var sprite2d : Sprite2D = $Sprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var initial_position = position

var direction :Vector2 = Vector2(0,1) # normalised 'looking' direction


func _ready():
	# Initialize all dialog related stuff
	dialog_actionable.dialog = dialog
	dialog_actionable.dialog_start = dialog_start
	# Make sure the balloon data exists in singleton
	DialogState.add_character(the_name,portrait,color)
	
	# Setup the sprite texture
	sprite2d.texture = sprite_texture
	
	anitree.active=true
	#Launch state machine
	state_machine.start_machine()


func _on_dialog_acti_actioned(actioneer):
	if(dialog):
		# On dialog, interrupt the current state abruptly, and transition it to the 
		# talking state, with the required data to turn the sprite.
		direction = (actioneer.global_position-global_position).normalized()
		state_machine.current_state.transition.emit(state_machine.current_state,'talking',{'direction' : direction})
	

