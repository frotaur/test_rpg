extends Area2D

class_name Actionable
"""
Actionable area. Call the action function to make something.
"""

signal actioned(actioneer : Node2D)

func action(actioneer : Node2D) :
	"""
		Activates the actionable, and has a reference to the actioneer node
		in case it is useful.
	"""
	actioned.emit(actioneer)
