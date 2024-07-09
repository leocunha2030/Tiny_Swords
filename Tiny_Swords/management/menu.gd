extends Control

# Função chamada quando o nó está pronto
func _ready() -> void:
	# Itera sobre todos os nós no grupo "button"
	for button in get_tree().get_nodes_in_group("button"):
		# Conecta o sinal "pressed" de cada botão à função on_button_pressed, passando o nome do botão como parâmetro
		button.pressed.connect(on_button_pressed.bind(button.name))

# Função chamada quando um botão é pressionado
func on_button_pressed(button_name: String) -> void:
	# Verifica o nome do botão pressionado
	match button_name:
		"New Game":
			# Se o botão "New Game" for pressionado, define o caminho da cena para o nível 1 e inicia a transição
			transition_screen.scene_path = "res://Tiny_Swords/management/Levels/level_1.tscn"
			transition_screen.fade_in()
		"Quit":
			# Se o botão "Quit" for pressionado, permite que o jogo seja encerrado e inicia a transição
			transition_screen.can_quit = true
			transition_screen.fade_in()
