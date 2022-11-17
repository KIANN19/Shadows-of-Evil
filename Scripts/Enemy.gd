extends KinematicBody2D

export var path_to_player := NodePath()

onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _player := get_node(path_to_player)
onready var _timer: Timer = $Timer
onready var _sprite: Sprite = $Sprite

var _velocity = Vector2.ZERO

func _ready() -> void: 
	_update_pathfinding()
	_timer.connect("timeout", self, "_update_pathfinding")
	
func _physics_process(delta: float) -> void:
	if _agent.is_navigation_finished():
		return
	
	var direction := global_position.direction_to(_agent.get_next_location())

	var desired_velocity := direction * 100
	var steering = (desired_velocity - _velocity) * delta * 4
	_velocity += steering
	
	_velocity = move_and_slide(_velocity)
	_sprite.rotation = _velocity.angle()
	
func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)


func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullet"): 
		queue_free()
