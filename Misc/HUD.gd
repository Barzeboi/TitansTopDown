extends CanvasLayer


var enemies
var enemycount = 0
signal on_enemy_death

func _ready():
	$Panel/Counter.text = String(enemycount)
	enemies = get_tree().get_nodes_in_group("Enemies")
	enemycount = enemies.size()
	
func on_enemy_death():
		enemycount -= 1
	
