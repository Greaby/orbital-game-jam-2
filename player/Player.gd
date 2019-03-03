extends KinematicBody2D

var speed = 200

var input_direction = Vector2()
var velocity = Vector2()

var oxygene = 500
var inverser = 1

func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    #input_direction.x = int(Input.is_action_pressed("right"))
    input_direction.y = (int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))) * inverser

    if input_direction:
        #velocity.x = lerp(velocity.x, input_direction.normalized().x * speed, .08)
        velocity.y = lerp(velocity.y, input_direction.normalized().y * speed, .08)
    else:
        #velocity.x = lerp(velocity.x, -200, .01)
        velocity.y = lerp(velocity.y, 0, .01)
        
    velocity.x = lerp(velocity.x, oxygene - 100, .08)
    
    GameState.hud.find_node("TextureProgress").value = oxygene
    
    $AnimatedSprite.rotation = velocity.angle() + PI / 2
    
    oxygene -= 20 * delta
    oxygene = clamp(oxygene, 0, 500)
    
    move_and_slide(velocity)

func _on_Pickup_body_entered(body):
    if body.is_in_group("pickable"):
        oxygene += body.points
        body.queue_free()
        
        if body.points > 0:
            emmit_oxy_particle()
        elif body.points == 0:
            inverser = -1
            var inverse_timer = Timer.new()
            inverse_timer.connect("timeout",self,"reset_inverse")
            inverse_timer.wait_time = 6
            add_child(inverse_timer) #to process
            inverse_timer.start() #to start
        else:
            emmit_co2_particle()

func emmit_oxy_particle():
    $OxyParticles.emitting = true
    yield(get_tree().create_timer(.2), "timeout")
    $OxyParticles.emitting = false
    
func emmit_co2_particle():
    $Co2Particles.emitting = true
    yield(get_tree().create_timer(.2), "timeout")
    $Co2Particles.emitting = false
    
func reset_inverse():
    inverser = 1
    