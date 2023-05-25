extends KinematicBody2D

export var BulletBlood = preload("res://Scenes/BulletBlood.tscn")
#Laddar blod animationen från en annan scen.
export var path_to_player := NodePath()
#Anropar NavigationAgent2D

onready var animPlayer = $AnimationPlayer
onready var _agent: NavigationAgent2D = $NavigationAgent2D
onready var _player := get_node(path_to_player)
onready var _timer: Timer = $Timer
onready var _sprite: Sprite = $Sprite
onready var Hbar = $TextureProgress
#Anropar noder ifrån scriptet

var health = 5
var dead = false
var taking_damage = false
var Hit = false
var m
#Var m finns för att undvika error då change scen returnerar ett värde.
#Sätter livsmängd och börjar med att säga att spelaren är vid liv och att spelaren inte tar skada.

var _velocity = Vector2.ZERO

func _ready() -> void: 
	_update_pathfinding()
	m = _timer.connect("timeout", self, "_update_pathfinding")
	animPlayer.play("Run")
	#Uppdaterar navigationen med hastigheten 0.1 sec för att enemys ska kunna hitta rätt till spelaren, spelar en spring animation.
	
func _physics_process(delta: float) -> void:
	pass
	
	var direction := global_position.direction_to(_agent.get_next_location())

	var desired_velocity := direction * 400
	var steering = (desired_velocity - _velocity) * delta * 1
	_velocity += steering

	_velocity = move_and_slide(_velocity)
	#Konstant jakt efter spelaren med NavigationAgent2D pathfinding, ställer in hastighet på enemyn
	
	
func _update_pathfinding() -> void:
	_agent.set_target_location(_player.global_position)
	#Uppdaterar target location efter player location.

func _on_Area2D_body_entered(body):
	if body.is_in_group("Bullet"): 
		Hit = true
		var blood = BulletBlood.instance() as Node2D
		blood.position = get_global_position()
		get_parent().add_child(blood)
		
		if Hit == true:
			health -= 1
			Hbar.value = health
			taking_damage = true
			if taking_damage == true:
				pass
			if health <= 0:
				dead = true
				get_tree().current_scene._add_point()
				queue_free()
				
	Hbar.hide()
	if health < 5:
		Hbar.show()
				
#Om fienden (inte vägg) träffas av bulleten, spelas alla animationer tidigare nämnt, och en blod splatter där enemyn träffas.
#Enemy har 5 health, om enemyn träffas av en bullet tappar den ett liv, om den har slut på liv dör den
#Enemyn har en healthbar som visar hur mycket liv den har kvar, för att undvika för mycket på skärmen visar jag bara liv på enemys som har tagit skada och inte alla med fullt liv.
	
	
func _on_Give_dmg_body_entered(body):
	if body.get("PLAYE") == "Player":
		animPlayer.play("Attack")
	
func _on_Give_dmg_body_exited(body):
	if body.get("PLAYE") == "Player":
		animPlayer.play("Run")
	
#om enemyn är i kollisionsbavstånd med spelaren så skickar den en signal till en annan funktion som gör så att spelaren tar skada.
#Spelar en attack animation
