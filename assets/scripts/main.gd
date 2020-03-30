extends Control

signal new_game(arr)
signal fail
signal win

onready var grid = $"CenterContainer/GridContainer"
onready var btn_new_game = $"CenterContainer/MobileArea/TBtn_NewGame"
onready var status_label = $"CenterContainer/MobileArea/Label_Status"
onready var log_label = $"CenterContainer/MobileArea/Label_Log"

const CARD_SCENE = preload("res://assets/scenes/card.tscn")

const TIME_REMEBER = 5
const CARD_COUNT = 9

var nums = []
var d_time = 0
var cur_step = -1
var start_time
var end_time


func _ready() -> void:
	randomize()
	
	for card in grid.get_children():
		card.queue_free()

	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")

	for i in CARD_COUNT:
		var card = CARD_SCENE.instance()
		card.name = "Card" + str(i + 1)
		grid.add_child(card)
		card.connect("pressed", grid, "_on_card_pressed", [card])
		#card.call_deferred("fix_card_anim")

	connect("fail", self, "_on_fail")
	connect("win", self, "_on_win")
	connect("new_game", self, "_on_new_game")


func _on_fail():
	cur_step = -1
	status_label.text = "FAIL"
	grid.close_cards()
	btn_new_game.visible = true


func _on_win():
	end_time = OS.get_unix_time()
	d_time = end_time - start_time
	print(d_time)
	cur_step = -1
	status_label.text = "WIN"
	yield(get_tree().create_timer(0.5), "timeout")
	grid.close_cards()
	btn_new_game.visible = true


func _on_Btn_NewGame_pressed() -> void:
	nums.clear()
	for i in CARD_COUNT:
		nums.append(i + 1)
	nums.shuffle()
	emit_signal("new_game", nums)
	btn_new_game.visible = false


func _on_new_game(arr: Array) -> void:
	#print_matrix()
	start_time = OS.get_unix_time()
	cur_step = 0
	grid.open_cards()
	var card
	var i = 0

	for num in arr:
		card = grid.get_child(i)
		card.text = str(num)
		i += 1

	for i in TIME_REMEBER:
		status_label.text = str(TIME_REMEBER - i)
		yield(get_tree().create_timer(1), "timeout")
	status_label.text = ""

	grid.close_cards()

"""
func print_matrix():
	var i = 1
	log_label.text += "\n=====\n"
	for n in nums:
		log_label.text += str(n)
		if i % 3 == 0:
			log_label.text += "\n"
		i += 1


func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_F4 and event.pressed:
			log_label.visible = !log_label.visible 
"""
