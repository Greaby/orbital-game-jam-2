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
    var globule
    
    if r % 100 >= 95:
        globule = load(globules[2]).instance()
    elif 85 <= r % 100 and r % 100 < 95:
        globule = load(globules[0]).instance()
    elif 65 <= r % 100 and r % 100 < 75:
        globule = load(globules[1]).instance()
    else:
        globule = load("res://globule/Globule.tscn").instance()
    globule.position = position
    get_parent().get_parent().find_node("Items").call_deferred("add_child", globule)

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()
