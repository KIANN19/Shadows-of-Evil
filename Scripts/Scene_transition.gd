extends CanvasLayer
var k

func change_scene(target: String) -> void:
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	k = get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")
	
#När en scen byts så spelas en animation som är döpt till dissolve, när animationen är slut så ändras scenen till den scen som spelaren valde..
#Detta är ett autoload skript döpt till ScenTransition.
