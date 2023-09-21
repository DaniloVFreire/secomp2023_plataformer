extends Area2D


func collected():
	queue_free()


func _on_body_entered(body):
	collected()
