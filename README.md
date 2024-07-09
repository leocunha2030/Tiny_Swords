# Tiny Swords Game
## Descrição
Tiny Swords é um jogo de ação 2D onde o jogador controla um personagem armado com uma espada. O objetivo do jogo é derrotar inimigos, completar níveis e alcançar a maior pontuação possível. O jogo apresenta várias mecânicas, como movimentação, ataques, animações, transições entre cenas e efeitos sonoros.

## Estrutura do Projeto

1. CharacterBody2D
Este nó representa o personagem principal do jogo. Ele contém scripts que gerenciam a movimentação, animações, ataques e saúde do personagem.

-character.gd: Controla a movimentação, ataque e animações do personagem.

2. Enemy
Os inimigos no jogo também são controlados por nós CharacterBody2D. Eles têm comportamento semelhante ao do personagem principal, mas com algumas diferenças, como a lógica para seguir e atacar o jogador.

-enemy.gd: Controla a movimentação, ataque e animações dos inimigos.

3. AttackArea
Uma área que detecta colisões para gerenciar ataques.

-attack_area.gd: Gerencia a detecção de colisões para aplicar dano aos inimigos ou ao jogador.

4. TransitionScreen
Gerencia as transições entre cenas e armazena informações globais, como pontuação e saúde do jogador.

-transition_screen.gd: Controla as animações de transição e troca de cenas.

5. Interface
A interface do usuário para exibir informações como saúde e pontuação do jogador.

-interface.gd: Atualiza os elementos da interface conforme necessário.

6. SoundEffects
Gerencia a reprodução de efeitos sonoros no jogo.

-sound_effects.gd: Carrega e toca efeitos sonoros, e remove-se após a reprodução.

## Como Jogar
Use as teclas de seta ou WASD ou as setas direcionais para mover o personagem.
Pressione a tecla de ataque (Clique esquerdo do mouse ou espaço) para atacar inimigos.
Complete níveis derrotando todos os inimigos e avançando para a próxima fase.

## Como rodar o jogo
### Abra a pasta "Web_Build"
### Execute "Tiny_Swords.exe"
