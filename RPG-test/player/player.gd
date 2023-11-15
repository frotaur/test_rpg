extends CharacterBody2D


const SPEED = 300.0

@onready var animo = $AnimationPlayer
@onready var anitree = $AnimationTree

var direction : Vector2 = Vector2.ZERO

func _ready():
	anitree.active=true
	
func _physics_process(delta):
	move_and_slide()


	
func _input(event):
	direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if(direction):
		velocity = direction*SPEED
	else :
		velocity = Vector2.ZERO
	update_anim_params()

func update_anim_params():
	if(not direction):
		anitree["parameters/conditions/is_walking"]=false
		anitree["parameters/conditions/is_idle"]=true
	else :
		anitree["parameters/conditions/is_idle"]=false
		anitree["parameters/conditions/is_walking"]=true
		
	anitree["parameters/Idle/blend_position"]=direction
	anitree["parameters/Walk/blend_position"]=direction
