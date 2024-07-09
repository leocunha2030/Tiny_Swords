extends Area2D

# Exporta a variável para definir o dano causado
@export var damage: int = 1

# Função chamada quando um corpo entra na área
func _on_body_entered(body) -> void:
	# Atualiza a saúde do corpo (geralmente um inimigo ou jogador) com o valor do dano
	body.update_health(damage)

# Função chamada quando o tempo de vida (timer) expira
func _on_life_time_timeout() -> void:
	# Remove este nó da cena
	queue_free()
	pass # Substitua pelo corpo da função, se necessário.
