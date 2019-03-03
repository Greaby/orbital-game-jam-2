extends RigidBody2D

func _process(delta):
    if GameState.player.position.x - 1280 > position.x:
        queue_free()

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
