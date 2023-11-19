extends Node
class_name StateMachine 

@export var initial_state : State

var states : Dictionary  = {}
var current_state : State

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(_on_child_transition)

func start_machine():
	"""
		Starts the state machine. That way, all nodes are readied for sure
	"""
	if initial_state :
		initial_state.enter({})
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state :
		current_state.update(delta)

func _physics_process(delta):
	if current_state :
		current_state.physics_update(delta)

func _on_child_transition(state: State, new_state_name: String, data:Dictionary):
	if state != current_state :
		print("Child transition fucked up !")
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state :
		print("Couldn't find state ",new_state_name, " in children")
		return
	
	current_state.exit()
	new_state.enter(data)
	
	current_state = new_state
