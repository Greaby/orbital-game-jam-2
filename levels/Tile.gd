extends Node2D

signal new_tile

var globules = [
    "res://globule/Gobule.tscn"
];

func _ready():
    for connector in $Connectors.get_children():
        connector.connect("screen_entered", self, "_on_screen_entered", [connector])
        
    var timer = Timer.new()
    timer.connect("timeout",self,"spawn_globule")
    timer.wait_time = .5
    add_child(timer) #to process
    timer.start() #to start


func _on_screen_entered(connector):
    emit_signal("new_tile", connector.global_position)
    connector.queue_free()

func spawn_globule():
    for spawner in $Spawners.get_children():
        var globule = load(globules[randi() % globules.size()]).instance()
        globule.position = spawner.global_position
        get_parent().add_child(globule)
    