extends Node


var current_scene : Node = null
var entrance_name : String = ''
var global_pos_arrival = null # Vector2 or null
var prev_scene : String = ''

@onready var root = get_tree().root
# In case we need to instance the player, usually we wil avoid it if possible
@onready var player_scene = preload("res://player/player.tscn")


func _ready():
	#Autoloaded scenes are first, so pick the last one to get current scene
	current_scene = root.get_child(root.get_child_count()-1)

func goto_scene(path_or_packedscene,target_entrance_name,global_position_arrival:Vector2=Vector2.ZERO):
	"""
		Go to specified scene, and land at the entrance, specified
		by its name.
		Args :
			path_or_packedscene : path of target scene, or PackedScene.
			Highly prefer PackedScene because much more robust
			target_entrance_name : Name of the target marker where to 
			land the player. Must correspond to a scene-unique name in the
			target scene. Alternatively, if set to null, global_position_arrival
			will be used instead
			global_position_arrival : global_position for the player node on arrival
			is used only if the target_entrance_name is set to null.
	"""
	# Variables should be accessed by target scene to place player
	# If entrance_name is '', use global pos. Otherwise, use entrance_name
	if(target_entrance_name == null):
		entrance_name= ''
		global_pos_arrival=global_position_arrival
	else :
		entrance_name = target_entrance_name
		global_pos_arrival = null
		
	var s = make_packed(path_or_packedscene)
	
	call_deferred("_deferred_goto_scene",s)


func _deferred_goto_scene(scene : PackedScene):
	current_scene.free()
	current_scene = scene.instantiate()
	
	get_tree().root.add_child(current_scene)
	#Optional but recommended, not sure why.
	get_tree().current_scene = current_scene

	
func make_packed(path_or_packedscene) :
	var s : PackedScene = null
	if(path_or_packedscene is PackedScene):
		s = path_or_packedscene
	elif(path_or_packedscene is String):
		s = ResourceLoader.load(path_or_packedscene)
	
	return s
