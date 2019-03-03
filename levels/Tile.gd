extends Node2D

signal new_tile

var globules = [
    "res://globule/Oxygene.tscn",
    "res://globule/CO2.tscn"
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
        if randi() % 100 > 90:
            var globule = load(globules[randi() % globules.size()]).instance()
            globule.position = spawner.global_position
            get_parent().add_child(globule)
        else:
            var globule = load("res://globule/Globule.tscn").instance()
            globule.position = spawner.global_position
            get_parent().add_child(globule)
    

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
