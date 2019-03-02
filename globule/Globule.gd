extends RigidBody2D

var sprites = [
    "res://globule/assets/globule-1.png",
    "res://globule/assets/globule-2.png",
    "res://globule/assets/globule-3.png"
]

func _ready():
    $Sprite.texture = load(sprites[randi() % sprites.size()])