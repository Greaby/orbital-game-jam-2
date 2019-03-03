extends RigidBody2D

var sprites = [
    "res://globule/assets/globule-1.png",
    "res://globule/assets/globule-2.png",
    "res://globule/assets/globule-3.png"
]

func _ready():
    $Sprite.texture = load(sprites[randi() % sprites.size()])
    
func _process(delta):
    if GameState.player.position.x - 1280 > position.x:
        queue_free()

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
