extends Node2D


var rng = RandomNumberGenerator.new()

@export var nfiles: int = 10
@onready var fly_scene = preload("res://scenes/fly.tscn")
@onready var bee_scene = preload("res://scenes/bee.tscn")

var movement_scripts: Array[String] = [
	"res://scripts/noised.gd",
	"res://scripts/random_step.gd",
	"res://scripts/simple_motion.gd"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize() 
	
	for i in nfiles:
		var type: float = rng.randf()
		var instance
		
		if type <= 0.3:
			instance = bee_scene.instantiate()
		else:
			instance = fly_scene.instantiate()
		
		add_child(instance)
		
		var random_script_path: String = movement_scripts[rng.randi() % movement_scripts.size()]
		var movement_script: Script = load(random_script_path)
		
		instance.set_script(movement_script)
		
		instance.notification(NOTIFICATION_READY)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
