extends KinematicBody2D
class_name Player

signal set_bomb(player_id, world_pos)

export var speed = 64

export var id = 0

var move_up_action := "move_up"
var move_down_action := "move_down"
var move_right_action := "move_right"
var move_left_action := "move_left"
var set_bomb_action := "set_bomb"

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	move_up_action += str(id)
	move_down_action += str(id)
	move_right_action += str(id)
	move_left_action += str(id)
	set_bomb_action += str(id)
	pass # Replace with function body.


func _physics_process(delta):
	var motion = velocity * delta
	move_and_collide(motion)
	
	
func _process(delta):
	if Input.is_action_pressed(move_left_action):
		velocity.x = -1
	elif Input.is_action_pressed(move_right_action):
		velocity.x = 1
	else:
		velocity.x = 0
	
	if Input.is_action_pressed(move_up_action):
		velocity.y = -1
	elif Input.is_action_pressed(move_down_action):
		velocity.y = 1
	else:
		velocity.y = 0
		
	velocity = velocity.normalized() * speed
	
	if Input.is_action_just_pressed(set_bomb_action):
		set_bomb()


func set_bomb():
	emit_signal("set_bomb", id, position)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
