extends Node2D

var tiles = [
    "res://levels/Tile1.tscn",
    "res://levels/Tile2.tscn",
    "res://levels/Tile3.tscn",
    "res://levels/Tile4.tscn"
]

func _ready():
    $Tiles/Tile.connect("new_tile", self, "add_tile")

func add_tile(position):
    var tile = load(tiles[randi() % tiles.size()]).instance()
    tile.position = position
    tile.position.y -= tile.find_node("SpawnPosition").position.y
    tile.connect("new_tile", self, "add_tile")
    
    $Tiles.add_child(tile)