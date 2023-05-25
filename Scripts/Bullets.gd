extends RigidBody2D

export var BulletSmoke = preload("res://Scenes/BulletSmoke.tscn")
export var BulletImpact = preload("res://Scenes/BulletImpact.tscn")
#Importerar kollisionseffekterna från andra scener

func _ready():
	$AnimatedSprite.frame = 0
	#Animationsspelaren ska börja från bild 0 och värdet ökar för varje bild.

func _on_Bullet_body_entered(body):
	if !body.is_in_group("enemy"):
		var smoke = BulletSmoke.instance() as Particles2D
		smoke.position = get_global_position()
		smoke.rotation_degrees = rotation
		get_parent().add_child(smoke)
		
		var impact = BulletImpact.instance() as Node2D
		impact.position = get_global_position()
		get_parent().add_child(impact)
		queue_free()
		
#Om bulleten träffar målet enemy så kommer smoke och impact effekten att spelas där skottet träffar. med get_global_posision vet vi vart skottet träffar och spelar animationerna där.
#Roterar effekterna baserat på riktning
