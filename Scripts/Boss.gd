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

var health = 25
var dead = false
var taking_damage = false
var Hit = false
var m
#Var m finns för att undvika error då change scen returnerar ett värde.
#Sätter livsmängd och börjar med att säga att spelaren är vid liv och att spelaren inte tar skada.

var _velocity = Vector2.ZERO
var bullet = preload("res://Scenes/BossBullets.tscn")
var bullet_speed = 800
var fire_rate = 0.5
var can_fire = true
var positions = 6
var section = randi() % 2 
var Player = preload("res://Scenes/Player.tscn")
const WIDTH = 1024
const HEIGHT = 600

func _ready() -> void: 
	_update_pathfinding()
	m = _timer.connect("timeout", self, "_update_pathfinding")
	animPlayer.play("Run")
	#Uppdaterar navigationen med hastigheten 0.1 sec för att enemys ska kunna hitta rätt till spelaren, spelar en spring animation.
	
func _physics_process(delta: float) -> void:
	pass
	
	var direction := global_position.direction_to(_agent.get_next_location())

	var desired_velocity := direction * 320
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
		yield(get_tree().create_timer(positions), "timeout")
		var player = Player.instance()
		if section == 0:
			global_position = player.global_position + Vector2(-WIDTH/2 - 20, rand_range(-HEIGHT/2, HEIGHT/2))
		elif section == 1:
			global_position = player.global_position + Vector2(WIDTH/2 + 20, rand_range(-HEIGHT/2, HEIGHT/2))
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
	if health < 25:
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


func _on_Shoot_body_entered(body):
	fire_rate = 0.3
	for n in 999999:
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(get_angle_to(body.get_global_position())))
		get_tree().get_root().add_child(bullet_instance)
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func _on_Shoot_body_exited(body):
	fire_rate = 50
