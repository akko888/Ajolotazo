extends Node2D

func _ready() -> void:
	$GUI/Progress_Bars/Player1/Control/TextureProgressBar.setup($Player1)
	$GUI/Progress_Bars/Player2/Control/TextureProgressBar.setup($Player2)
