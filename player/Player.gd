extends KinematicBody2D

var speed = 200

var input_direction = Vector2()
var velocity = Vector2()

func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    input_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
    input_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
    
    velocity.x = lerp(velocity.x, input_direction.normalized().x * speed, .1)
    velocity.y = lerp(velocity.y, input_direction.normalized().y * speed, .1)
    
    move_and_slide(velocity)