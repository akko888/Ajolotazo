extends Control

var currentScene: String = "title"

@onready var screens = {
	"title" : $TitleScreen,
	"mode" : $ModeSelect,
	"char" : $CharSelect,
	"stage" : $StageSelect,
	"gallery" : $Gallery
}

func _ready() -> void:
	$TitleScreen.startPressed.connect(_on_navigation_button_pressed)
	$ModeSelect.onModePressed.connect(_on_navigation_button_pressed)
	$CharSelect.onCharPressed.connect(_on_navigation_button_pressed)
	$CharSelect.characterConfirmed.connect(_on_character_confirmed)

func go_to(screen: String) -> void:
	var tween = create_tween()
	tween.tween_property(screens[currentScene],"modulate:a", 0.0, 0.15)
	tween.tween_callback(func():
		for s in screens.values(): s.hide()
		screens[screen].show()
	)
	tween.tween_property(screens[screen],"modulate:a", 1.0, 0.15)
	currentScene = screen

func _on_navigation_button_pressed(destination: String):
	go_to(destination)

func _on_character_confirmed(p1Path: String, p2Path: String) -> void:
	GameData.player1_stats = load(p1Path)
	GameData.player2_stats = load(p2Path)
	get_tree().change_scene_to_file("res://Scenes/Scene.tscn")
