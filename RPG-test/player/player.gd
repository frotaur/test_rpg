extends CharacterBody2D


const SPEED = 300.0

@onready var animo = $AnimationPlayer

func _physics_process(delta):
	move_and_slide()

func _input(event):
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if(direction):
		velocity = direction*SPEED
		if(abs(direction.x)>abs(direction.y)):
			if(direction.x>0):
				animo.play("walk_e")
			else :
				animo.play("walk_w")
		else :
			if(direction.y>0):
				animo.play("walk_s")
			else :
				animo.play("walk_n")
	else :
		velocity = Vector2.ZERO
		animo.play("RESET")
		
