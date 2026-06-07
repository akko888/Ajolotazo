extends Control

signal characterConfirmed(p1Path: String, p2Path: String)
signal onCharPressed

@onready var containter1 = $Player1Chars
@onready var container2 = $Playe2Chars
@onready var confirmButton = $ConfirmButton
@onready var statsPanel = [$Player1Select/StatsPanel1, $Player2Select/StatsPanel2]

var p1selection: String = ""
var p2selection: String = ""
var selectedCards = [null, null]

const CardUI = preload("res://Scenes/GUI/CardUI.tscn")

func _ready() -> void:
	confirmButton.disabled = true
	confirmButton.pressed.connect(_on_confirm_button_pressed)
	for character in GameData.CHARACTERS:
		_add_card(character, containter1, 1)
		_add_card(character, container2, 2)

func _add_card(character: Dictionary, container: Node, player: int) -> void:
	var card = CardUI.instantiate()
	container.add_child(card)
	card.setup(character)
	card.cardSelected.connect(_on_card_selected.bind(player))

func _on_card_selected(statsPath: String, card: TextureButton, player: int) -> void:
	if player == 1:
		if selectedCards[0] and selectedCards[0] != card:
			selectedCards[0].button_pressed = false
		selectedCards[0] = card
		p1selection = statsPath
	else:
		if selectedCards[1] and selectedCards[1] != card:
			selectedCards[1].button_pressed = false
		selectedCards[1] = card
		p2selection = statsPath
	
	var stats = load(statsPath)
	_show_stats(stats, player)
	
	confirmButton.disabled = p1selection.is_empty() or p2selection.is_empty()

func _show_stats(stats: CharacterStats, player: int) -> void:
	var panel = statsPanel[player - 1]
	panel.visible = true
	var label = statsPanel[player - 1].get_node("Label")
	
	var text = ""
	text += "Vida: %s\n" % stats.maxHealth
	text += "Daño Dash: %s\n" % stats.dashData["damage"]
	text += "Daño Salto: %s\n" % stats.jumpData["damage"]
	for i in stats.comboData.size():
		text += "Golpe %s: %s Daño\n" % [i + 1, stats.comboData[i]["damage"]]
	
	label.text = text

func reset() -> void:
	p1selection = ""
	p2selection = ""
	for card in selectedCards:
		if card != null:
			card.button_pressed = false
	selectedCards = [null, null]
	for panel in statsPanel:
		panel.get_node("Label").text = ""
	confirmButton.disabled = true

func _on_confirm_button_pressed() -> void:
	characterConfirmed.emit(p1selection, p2selection)

func _on_back_button_pressed() -> void:
	reset()
	onCharPressed.emit("mode")
