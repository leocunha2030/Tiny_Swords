extends Node2D

var kill_count: int = 0
@onready var interface: CanvasLayer = get_node("Interface")
@onready var health_label: Label = interface.get_node("Health")
@onready var score_label: Label = interface.get_node("Score")
@export var target_kill_count: int
@export var next_level_scene_path: String
@export var current_level_scene_path: String
func _ready() -> void:
	transition_screen.scene_path = current_level_scene_path
	update_health(transition_screen.player_health)
	update_score(transition_screen.player_score)
	
func update_health(new_health: int) -> void:
	health_label.text = "HP: " + str(new_health)
	
func update_score(new_Score: int) -> void:
	score_label.text = "SCORE: " + str(new_Score)
func increase_kill_count() -> void:
	kill_count += 1
	if kill_count == target_kill_count:
		transition_screen.scene_path = next_level_scene_path
		transition_screen.fade_in(true)