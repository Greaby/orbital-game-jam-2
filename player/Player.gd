extends KinematicBody2D

var speed = 200

var input_direction = Vector2()
var velocity = Vector2()

func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    input_direction.x = int(Input.is_action_pressed("right"))
    input_direction.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

    if input_direction:
        velocity.x = lerp(velocity.x, input_direction.normalized().x * speed, .08)
        velocity.y = lerp(velocity.y, input_direction.normalized().y * speed, .08)
    else:
        velocity.x = lerp(velocity.x, -200, .01)
        velocity.y = lerp(velocity.y, 0, .01)
    
    move_and_slide(velocity)

func _on_Pickup_body_entered(body):
    if body.is_in_group("pickable"):
        body.queue_free()
