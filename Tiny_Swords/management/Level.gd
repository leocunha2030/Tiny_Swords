extends Node2D

# Variável para contar o número de inimigos mortos
var kill_count: int = 0

# Variáveis onready para obter nós da interface
@onready var interface: CanvasLayer = get_node("Interface")
@onready var health_label: Label = interface.get_node("Health")
@onready var score_label: Label = interface.get_node("Score")

# Exporta variáveis para o alvo de contagem de mortes, caminho da próxima cena e caminho da cena atual
@export var target_kill_count: int
@export var next_level_scene_path: String
@export var current_level_scene_path: String

# Função chamada quando o nó está pronto
func _ready() -> void:
	transition_screen.scene_path = current_level_scene_path
	update_health(transition_screen.player_health)
	update_score(transition_screen.player_score)

# Função para atualizar a saúde na interface
func update_health(new_health: int) -> void:
	health_label.text = "HP: " + str(new_health)

# Função para atualizar a pontuação na interface
func update_score(new_score: int) -> void:
	score_label.text = "SCORE: " + str(new_score)

# Função para aumentar a contagem de mortes
func increase_kill_count() -> void:
	kill_count += 1
	if kill_count == target_kill_count:
		# Se a contagem de mortes atingir o alvo, muda para a próxima cena e inicia a transição
		transition_screen.scene_path = next_level_scene_path
		transition_screen.fade_in(true)
