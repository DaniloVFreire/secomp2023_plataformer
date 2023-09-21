class_name BreakableBlock
extends StaticBody2D
var health = 3

func hit():
	health -= 1
	if health <= 0:
		destroy()
	else:
		$AnimationPlayer.play("hit")

func destroy():
	queue_free()

func set_animation_idle():
	$AnimationPlayer.play("idle")
