extends NpcState


var look_direction

func enter(data:Dictionary):
	super(data)
	look_direction = data.get('direction')
	if(look_direction):
		anitree["parameters/conditions/is_idle"]=true
		anitree["parameters/conditions/is_walking"]=false
		anitree["parameters/Idle/blend_position"]=look_direction
	npc.velocity = Vector2.ZERO

func _on_dialog_acti_dialog_ended():
	transition.emit(self,'stopped',{})
