class_name GameManager
extends Node

enum GameState {
    MENU = 0,
    PLAYING = 2,
    DEAD = 4,
    WIN = 8
}

var current_state = GameState.MENU
var is_paused = false

func set_game_state(state: GameState) -> void:
    match current_state:
        GameState.DEAD:
            pass
    



