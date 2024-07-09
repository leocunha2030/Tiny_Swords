extends CharacterBody2D

# Precarrega a cena da área de ataque do inimigo
const ATTACK_AREA : PackedScene = preload("res://Tiny_Swords/goblin/enemy_attack_area.tscn")

# Define um vetor de deslocamento para a posição da área de ataque
const OFFSET: Vector2 = Vector2(1, 22)

# Precarrega a cena do template de áudio para usar em efeitos sonoros
const audio_template: PackedScene = preload("res://Tiny_Swords/management/audio_template.tscn")

# Variáveis onready para obter nós da cena
@onready var dust: GPUParticles2D = get_node("Dust")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var aux_animation_player: AnimationPlayer = get_node("AuxAnimationPlayer")
@onready var texture: Sprite2D = get_node("Texture")

# Referência ao jogador
var player_ref: CharacterBody2D = null

# Exporta variáveis para pontuação, velocidade de movimento, distância limite e saúde
@export var score: int = 1
@export var move_speed: float = 192.0
@export var distance_threshold: float = 60.0
@export var health: int = 3
@export var can_die: bool = false

# Função chamada a cada frame de física
func _physics_process(_delta: float) -> void:
	if can_die:
		return
	if player_ref == null or player_ref.can_die:
		velocity = Vector2.ZERO
		animate()
		return

	var direction: Vector2 = global_position.direction_to(player_ref.global_position)
	var distance: float = global_position.distance_to(player_ref.global_position)
	
	if distance <= distance_threshold:
		animation.play("attack")
		dust.emitting = false
		return
	
	velocity = direction * move_speed
	move_and_slide()
	animate()  # Chama a função animate após atualizar a velocidade e mover o personagem

# Função para instanciar e adicionar a área de ataque
func spawn_attack_area() -> void:
	var attack_area = ATTACK_AREA.instantiate()
	attack_area.position = OFFSET
	add_child(attack_area)

# Função para animar o personagem
func animate() -> void:
	if velocity.x > 0:
		texture.flip_h = false
	if velocity.x < 0:
		texture.flip_h = true
		
	if velocity != Vector2.ZERO:
		animation.play("run")
		dust.emitting = true
		return
	dust.emitting = false
	animation.play("idle")

# Função para atualizar a saúde
func update_health(value) -> void:
	health -= value
	if health <= 0:
		can_die = true
		animation.play("death")
		return
		
	aux_animation_player.play("hit")

# Função chamada quando um corpo entra na área de detecção
func _on_detection_area_body_entered(body):
	player_ref = body
	animate()  # Garante que a animação seja atualizada quando o jogador entra na área de detecção

# Função chamada quando um corpo sai da área de detecção
func _on_detection_area_body_exited(_body):
	player_ref = null
	animate()  # Garante que a animação seja atualizada quando o jogador sai da área de detecção

# Função chamada quando uma animação termina
func _on_animation_animation_finished(anim_name: String) -> void:
	if anim_name == "death":
		transition_screen.player_score += score
		get_tree().call_group("level", "increase_kill_count")
		get_tree().call_group("level", "update_score", transition_screen.player_score)
		queue_free() 

# Função para gerar efeitos sonoros
func spawn_sfx(sfx_path: String) -> void:
	var sfx = audio_template.instantiate()
	sfx.sfx_to_play = sfx_path
	add_child(sfx)
