extends Area2D
signal pickup


func _on_WhosWho_body_entered(body):
	if body.name == "Player":
		emit_signal("pickup")
		body.pick_up("WhosWho")
		$Sprite/Particles2D.hide()
#Om player kolliderar med itemets hitbox, aktiveras den och ger dess powerup.
