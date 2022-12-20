extends RigidBody2D

export var BulletSmoke = preload("res://Scenes/BulletSmoke.tscn")
export var BulletImpact = preload("res://Scenes/BulletImpact.tscn")


func _ready():
	$AnimatedSprite.frame = 0

func _on_Bullet_body_entered(body):
	if !body.is_in_group("enemy"):
		var smoke = BulletSmoke.instance() as Particles2D
		smoke.position = get_global_position()
		get_parent().add_child(smoke)
		
		var impact = BulletImpact.instance() as Node2D
		impact.position = get_global_position()
		get_parent().add_child(impact)
		
		queue_free()
