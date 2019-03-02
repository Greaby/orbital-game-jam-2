extends Node2D

func _ready():
    $Tiles/Tile.connect("new_tile", self, "add_tile")

func add_tile(position):
    var tile = load("res://levels/Tile.tscn").instance()
    tile.position = position
    tile.position.y -= tile.find_node("SpawnPosition").position.y
    tile.connect("new_tile", self, "add_tile")
    
    $Tiles.add_child(tile)