extends NpcState


@export var move_speed := 10.


var move_direction : Vector2
var wander_radius : float
var wandering = true
var tar_point : Vector2

func randomize_wander():
	tar_point = npc.initial_position+\
				Vector2(randf_range(-wander_radius/2,wander_radius/2),
						randf_range(-wander_radius/2,wander_radius/2))
	adjust_direction()

func adjust_direction():
	move_direction = npc.position.direction_to(tar_point)
	anitree["parameters/Idle/blend_position"]=move_direction
	anitree["parameters/Walk/blend_position"]=move_direction
	npc.velocity = move_direction*move_speed
	
func enter(data:Dictionary):
	super(data)
	wander_radius = npc.wander_radius
	anitree["parameters/conditions/is_idle"]=false
	anitree["parameters/conditions/is_walking"]=true
	randomize_wander()

func exit():
	pass

func update(delta :float):
	adjust_direction()
	if (npc.position.distance_to(tar_point))<0.1: 
		var re_wander = randi_range(0,1)
		if(re_wander==1):
			randomize_wander()
		else :
			transition.emit(self,'stopped',{})

func physics_update(delta : float):
	npc.move_and_slide()

