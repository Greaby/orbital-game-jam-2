extends Node2D

signal new_tile

func _ready():
    for connector in $Connectors.get_children():
        connector.connect("screen_entered", self, "_on_screen_entered", [connector])

func _on_screen_entered(connector):
    emit_signal("new_tile", connector.global_position)
    connector.queue_free()
