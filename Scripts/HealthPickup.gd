extends Area2D
signal pickup


func _on_HealthPickup_body_entered(body):
	if body.name == "Player":
		emit_signal("pickup")
		body.pick_up("HealthPickup")
		queue_free()

#Om spelaren går över objektet så skickas det en signal till en annan funktion som gör så att spelaren får liv.
#Que_free tar bort objektet efter en gång användning.
#Om player kolliderar med itemets hitbox, aktiveras den och ger dess powerup.
