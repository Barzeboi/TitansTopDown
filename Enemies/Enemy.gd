extends KinematicBody2D
class_name Enemy

var velocity
signal on_die
onready var HUD = load("res://Misc/HUD.gd")
onready var enemy = get_node("/root/TestMap/Skirmisher")

func _ready():
	enemy.connect("on_die",HUD, "on_enemy_death")
