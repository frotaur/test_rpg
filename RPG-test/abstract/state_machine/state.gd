extends Node
class_name State

signal transition(state : State, new_state_name : String, data)

func enter(data:Dictionary):
	pass
	
func exit():
	pass

func update(delta :float):
	pass

func physics_update(delta : float):
	pass
