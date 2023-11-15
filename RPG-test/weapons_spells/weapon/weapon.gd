extends Node2D

@export var damage : float = 0.

@onready var hitbox = %Hitbox
@onready var animator = $AnimationPlayer

var attack_buffered = false
# For now can always buffer. Maybe in the future, only on a window at end of animation
var bufferable = true 

var swing_number = 0

# This code is awful. Really, I should have a state machine to do that shit. But for now, leave like that
func _ready():
	hitbox.damage = damage

func _input(event):
	if Input.is_action_just_pressed("attack"):
		attack()


func attack():
	if(bufferable and swing_number>0):
		# If we are swinging, just note that we buffered attack
		attack_buffered = true
	else:
		# Else we are idle, swing now
		animator.play("swing1")
		swing_number=1



func _on_animation_player_animation_finished(anim_name):
	print('finished ', anim_name,' buffer is : ', attack_buffered)
	if(anim_name=="RESET"):
		return # nothing to do
	
	if(attack_buffered):
		match(anim_name):
			"swing1":
				swing_number=2
			"swing2":
				swing_number=3
			_:
				swing_number=0
	else :
		swing_number=0
	if(swing_number==0):
		animator.play("RESET")
	else :
		animator.play("RESET") # Reset position before going to next one
		animator.queue("swing"+str(swing_number))
		attack_buffered=false
