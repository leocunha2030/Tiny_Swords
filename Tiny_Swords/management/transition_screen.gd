extends CanvasLayer

# Caminho da cena para a qual será feita a transição
var scene_path: String = ""

# Variável onready para obter o nó AnimationPlayer da cena
@onready var animation: AnimationPlayer = get_node("Animation")

# Variável para indicar se o jogo pode ser encerrado
var can_quit: bool = false

# Variáveis para armazenar a pontuação e a saúde do jogador
var player_score: int = 0
var player_health: int = 0

# Função para iniciar a animação de fade in
func fade_in(opt: bool = false) -> void:
	if opt:
		# Se opt for verdadeiro, toca a animação "special_fade_in"
		animation.play("special_fade_in")
		return
	# Caso contrário, toca a animação "fade_in"
	animation.play("fade_in") 

# Função chamada quando uma animação termina
func _on_animation_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_in":
		if can_quit:
			# Se can_quit for verdadeiro, encerra o jogo
			get_tree().quit()
			return
		# Caso contrário, muda para a cena especificada em scene_path
		get_tree().change_scene_to_file(scene_path)
		# Toca a animação "fade_out"
		animation.play("fade_out")
	if anim_name == "special_fade_in":
		# Muda para a cena especificada em scene_path
		get_tree().change_scene_to_file(scene_path)
		# Toca a animação "fade_out"
		animation.play("fade_out")
