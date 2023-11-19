extends CharacterBody2D

class_name Player

@export var SPEED = 300.0
@export var CAM_ADVANCE = 8.
const ADVANCE_PX_SPEED = 20.

@onready var animo = $AnimationPlayer
@onready var anitree = $AnimationTree
@onready var interactor = %Interactor
@onready var cam = %PlayerCam
@onready var weapon = %Weapon

var direction : Vector2 = Vector2.ZERO

# For tweening the camera
var last_direction : Vector2 = Vector2.ZERO
var cam_tween_time = CAM_ADVANCE/ADVANCE_PX_SPEED
var tween : Tween


func _ready():
	anitree.active=true
	
	CameraController.zoom_changed.connect(_on_zoom_change)
	
func _physics_process(delta):
	move_and_slide()


func _input(event):
	handle_movement_input()
	
	if(not DialogState.talking):
		if(Input.is_action_just_pressed("interact")):
			var potentials_interact = interactor.get_overlapping_areas()
			# For now, interact with the first
			var can_interact = (potentials_interact.size()>0) and potentials_interact[0].has_method("action")
			if(can_interact):
				potentials_interact[0].action(self)
		if Input.is_action_just_pressed("attack"):
			weapon.attack()
	move_camera()
	update_anim_params()

func handle_movement_input():
	if(not DialogState.talking):
		direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	else :
		direction = Vector2.ZERO
		
	if(direction):
		velocity = direction*SPEED
	else :
		velocity = Vector2.ZERO
		direction=Vector2.ZERO
	
func move_camera():
	if(last_direction!=direction):
		# Activate tween, we changed direction
		if(tween):
			tween.kill()
		tween=create_tween()
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.set_ease(Tween.EASE_IN)
		var tween_time
		if(direction==Vector2.ZERO):
			tween_time = cam_tween_time/2
		else :
			tween_time = cam_tween_time
		tween.tween_property(cam,"position",direction*CAM_ADVANCE,tween_time)
		last_direction=direction

func _on_zoom_change(final_zoom):
	var zoom_tween = create_tween()
	zoom_tween.tween_property(cam,"zoom",final_zoom*Vector2.ONE,1)

func update_anim_params():
	if(not direction):
		anitree["parameters/conditions/is_walking"]=false
		anitree["parameters/conditions/is_idle"]=true
	else :
		anitree["parameters/conditions/is_idle"]=false
		anitree["parameters/conditions/is_walking"]=true
		anitree["parameters/Idle/blend_position"]=direction
		anitree["parameters/Walk/blend_position"]=direction
		

