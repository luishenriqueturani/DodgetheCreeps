extends Node

@export (PackedScene) var Mob
var score

func _ready():
	randomize()
	$HUD.connect("start_game", Callable(self, "new_game"))










func game_over():
	$Music.stop()
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()

func new_game():
	$Music.play()
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")



func _on_MobTimer_timeout():
	
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instantiate()
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI /2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	mob.linear_velocity = Vector2(randf_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)
	$HUD.connect("start_game", Callable(mob, "on_start_game"))


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
