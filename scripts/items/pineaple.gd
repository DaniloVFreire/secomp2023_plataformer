extends Area2D


func collected():
	print('coletado')
	queue_free()


func _on_body_entered(body):
	collected()
