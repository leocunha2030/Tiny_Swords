extends CharacterBody2D

# Pré-carrega a cena de template de áudio para usar em efeitos sonoros
const audio_template: PackedScene = preload("res://Tiny_Swords/management/audio_template.tscn")

# Variáveis onready para obter nós da cena
@onready var dust: GPUParticles2D = get_node("Dust")
@onready var attack_area_collision: CollisionShape2D = get_node("AttackArea/Collision")
@onready var animation: AnimationPlayer = get_node("Animation")
@onready var texture: Sprite2D = get_node("Texture")
@onready var aux_animation_player: AnimationPlayer = get_node("AuxAnimationPlayer")

# Variável para controle de ataque
var can_attack: bool = true

# Exporta variáveis para velocidade de movimento, dano e saúde
@export var move_speed: float = 256.0
@export var damage: int = 1
@export var health: int = 5

# Variável para controle de morte
var can_die: bool = false

# Função chamada quando o nó está pronto
func _ready() -> void:
	if transition_screen.player_health != 0:
		# health = transition_screen.player_health #Deletar linha se não quiser manter a vida para a próxima fase
		return
	transition_screen.player_health = health

# Função chamada a cada frame de física
func _physics_process(_delta: float) -> void:
	if not can_attack or can_die:
		return
	move()
	animate()
	attack_handler()

# Função para mover o personagem
func move() -> void:
	var direction: Vector2 = get_direction()
	velocity = direction * move_speed
	move_and_slide()

# Função que lê as teclas das setas para mover o personagem
# O normalized é necessário
func get_direction() -> Vector2:
	return Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized()

# Função para animar o personagem
func animate() -> void:
	if velocity.x > 0:
		texture.flip_h = false
		attack_area_collision.position.x = 58
	if velocity.x < 0:
		texture.flip_h = true
		attack_area_collision.position.x = -58

	if velocity != Vector2.ZERO:
		animation.play("run")
		dust.emitting = true
		return

	dust.emitting = false
	animation.play("idle")

# Função para lidar com o ataque
func attack_handler() -> void:
	if Input.is_action_just_pressed("attack") and can_attack:
		can_attack = false
		dust.emitting = false
		animation.play("attack")
		pass

# Função chamada quando uma animação termina
func _on_animation_animation_finished(anim_name: String) -> void:
	match anim_name:
		"attack":
			can_attack = true
		"death":
			transition_screen.fade_in()
			transition_screen.player_score = 0
			transition_screen.player_health = 0

# Função chamada quando uma área de ataque colide com outro corpo
func _on_attack_area_body_entered(body) -> void:
	body.update_health(damage)

# Função para atualizar a saúde
func update_health(value) -> void:
	health -= value
	transition_screen.player_health = health
	get_tree().call_group("level", "update_health", health)

	if health <= 0:
		can_die = true
		animation.play("death")
		attack_area_collision.set_deferred("disabled", true)
		return

	aux_animation_player.play("hit")

# Função para gerar efeitos sonoros
func spawn_sfx(sfx_path: String) -> void:
	var sfx = audio_template.instantiate()
	sfx.sfx_to_play = sfx_path
	add_child(sfx)
