extends AudioStreamPlayer2D

# Variável para armazenar o caminho do efeito sonoro a ser tocado
var sfx_to_play: String = ""

# Função chamada quando o nó está pronto
func _ready() -> void:
	# Carrega o efeito sonoro a partir do caminho especificado
	stream = load(sfx_to_play)
	# Toca o efeito sonoro
	play()

# Função chamada quando o timer expira
func _on_timer_timeout():
	# Remove este nó da cena
	queue_free()
