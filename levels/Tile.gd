extends Node2D

signal new_tile

var globules = [
    "res://globule/Oxygene.tscn",
    "res://globule/CO2.tscn",
    "res://globule/Virus.tscn"
];

func _ready():
    for connector in $Connectors.get_children():
        connector.connect("screen_entered", self, "_on_screen_entered", [connector])
        
    var timer = Timer.new()
    timer.connect("timeout",self,"spawn_globules")
    timer.wait_time = .4
    add_child(timer) #to process
    timer.start() #to start
    
    for globule in $Globules.get_children():
        spawn_globule(globule.global_position)


func _on_screen_entered(connector):
    emit_signal("new_tile", connector.global_position)
    connector.queue_free()

func spawn_globules():
    for spawner in $Spawners.get_children():
        spawn_globule(spawner.global_position)
    
func spawn_globule(position):
    var r = randi()
    if r % 100 > 95:
        var globule = load(globules[2]).instance()
        globule.position = position
        get_parent().get_parent().find_node("Items").call_deferred("add_child", globule)
    elif r % 100 > 75:
        var globule = load(globules[randi() % 2]).instance()
        globule.position = position
        get_parent().get_parent().find_node("Items").call_deferred("add_child", globule)
    else:
        var globule = load("res://globule/Globule.tscn").instance()
        globule.position = position
        get_parent().get_parent().find_node("Items").call_deferred("add_child", globule)

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
