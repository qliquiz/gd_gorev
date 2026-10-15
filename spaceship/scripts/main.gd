extends Node2D

@onready var player = get_node("Player")
@onready var enemies = $enemies
@onready var enemy_scene = preload("res://scenes/enemy.tscn")
@onready var orbit_scene = preload("res://scenes/orbit_enemy.tscn")

var count := 10
var orbiting_enemy: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in count:
		var enemy_instance = (orbit_scene if i == 0 else enemy_scene).instantiate()
		enemy_instance.scale = Vector2(0.7,0.7)
		if i == 0:
			enemy_instance.target = player
			orbiting_enemy = enemy_instance
		enemies.add_child(enemy_instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for child in enemies.get_children():
		if child == orbiting_enemy:
			continue
		child.separate(enemies)
		child.cohesion(enemies)
		child.align(enemies)
