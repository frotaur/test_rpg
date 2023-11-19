extends State
class_name NpcState

"""
	State for finite state machine, sharing common code
	among states in the case of an NPC.
"""
@export var npc: Npc
var anitree : AnimationTree
var direction

func enter(data:Dictionary):
	anitree = npc.anitree

