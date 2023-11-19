extends NpcState


var look_direction : Vector2
var stop_time : float

	
func randomize_stop_time():
	look_direction = Vector2(randf_range(-1,1),randf_range(-1,1)).normalized()
	stop_time = randf_range(1,5)
	anitree["parameters/Idle/blend_position"]=look_direction
	anitree["parameters/Walk/blend_position"]=look_direction

func enter(data:Dictionary):
	super(data)
	anitree = npc.anitree
	anitree["parameters/conditions/is_idle"]=true
	anitree["parameters/conditions/is_walking"]=false
	npc.velocity = Vector2.ZERO
	stop_time=randf_range(1,5)

func exit():
	pass

func update(delta :float):
	if stop_time>0:
		stop_time -= delta
	else :
		var re_stop = randi_range(0,1)
		if(re_stop==1):
			randomize_stop_time()
		else :
			transition.emit(self,'walking',{})


func physics_update(delta : float):
	npc.move_and_slide()
