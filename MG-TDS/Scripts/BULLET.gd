extends RigidBody2D

func _ready():
	$BulletAnimation.frame = 0
	
func _on_Bullet_body_entered(body):
	if !body.is_in_group("enemy"):
		queue_free()
