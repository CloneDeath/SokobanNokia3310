extends Node2D

export(Array, PackedScene) var levels = [
	preload("res://Levels/Level01.tscn")
];
export var current_level = 0;
var current_level_node = null;

func _ready():
	load_level(current_level);

func load_level(level):
	if (current_level_node != null):
		current_level_node.queue_free();
		current_level_node = null;
	var level_scene = levels[level] as PackedScene;
	var level_instance = level_scene.instance();
	current_level_node = level_instance;
	add_child(level_instance);

func level_complete():
	if (current_level + 1 >= levels.size()):
		return;
	current_level += 1;
	load_level(current_level);

func _process(_delta):
	var nodes = get_tree().get_nodes_in_group("button");
	for node in nodes:
		if (!node.is_pressed()):
			return;
	level_complete();