extends Node2D

var tiles = [
    "res://levels/Tile1.tscn",
    "res://levels/Tile2.tscn",
    "res://levels/Tile3.tscn",
    "res://levels/Tile4.tscn",
    "res://levels/Tile5.tscn",
    "res://levels/Tile6.tscn"
]

func _ready():
    randomize()
    $Tiles/Tile.connect("new_tile", self, "add_tile")
    GameState.player = $Player
    
func _process(delta):
    $End.position.y = $Player.position.y
    $End.position.x = max($End.position.x, $Player.position.x - 740)

func add_tile(position):
    var tile = load(tiles[randi() % tiles.size()]).instance()
    tile.position = position
    tile.position.y -= tile.find_node("SpawnPosition").position.y
    tile.connect("new_tile", self, "add_tile")
    
    $Tiles.add_child(tile)

func _on_End_body_entered(body):
    get_tree().change_scene("res://Main.tscn")
