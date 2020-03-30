extends Control

signal pressed

onready var btn : Label = $"TextureButton"
onready var label : Label = $"TextureButton/Label"
onready var card_anim_player : AnimationPlayer = $"TextureButton/AnimationPlayer"
var text = "" setget set_text, get_text
var face = false


func _ready():
	btn.connect("pressed", self, "_on_pressed")


func _on_pressed():
	emit_signal("pressed")


func set_text(val: String) -> void:
	label.text = val


func get_text():
	return label.text


func flip_card(i_face=false, i_unface=false):
	if not(card_anim_player.is_playing()):
		if face:
			if !i_face:
				card_anim_player.play_backwards("card_flip")
				face = !face
		else:
			if !i_unface:
				card_anim_player.play("card_flip")
				face = !face


"""
func fix_card_anim() -> void:
	var anim : Animation = card_anim_player.get_animation("card_flip").duplicate()
	var track_idx = anim.find_track(".:rect_position")
	anim.track_set_key_value(track_idx, 0, rect_position)
	anim.track_set_key_value(track_idx, 1, rect_position + Vector2(70, 0))
	anim.track_set_key_value(track_idx, 2, rect_position)
	card_anim_player.remove_animation("card_flip")
	card_anim_player.add_animation("card_flip", anim)
"""
