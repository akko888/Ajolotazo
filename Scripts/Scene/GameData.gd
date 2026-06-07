extends Node

var player1_stats: CharacterStats = null
var player2_stats: CharacterStats = null
var selected_Stage: String = ""

const CHARACTERS = [
	{"name" : "Tacos el wero uwu", "stats" : "res://Config/Characters/Taquero.tres", "preview": preload("res://Assets/Characters/Taquero/Taquero.png") },
	{"name" : "La chillona", "stats" : "res://Config/Characters/Llorona.tres", "preview" : preload("res://Assets/Characters/Llorona/Llorona.png") },
	{"name" : "La muertinha", "stats": "res://Config/Characters/Catrina.tres", "preview" : preload("res://Assets/Characters/Catrina/Catrina.png") },
	{"name" : "El santo", "stats": "res://Config/Characters/Luchador.tres", "preview" : preload("res://Assets/Characters/Luchador/Luchador.png") }
]

func reset() -> void:
	player1_stats = null
	player2_stats = null
	selected_Stage = ""
