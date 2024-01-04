extends RigidBody2D

@export var min_speed = 150
@export var max_speed = 250
var mob_types = ["walk", "swim", "fly"]


func _ready():
	$AnimatedSprite2D.animation = mob_types[randi() % mob_types.size()]
	pass # Replace with function body.





func _on_Visibility_screen_exited():
	queue_free()
	pass # Replace with function body.
