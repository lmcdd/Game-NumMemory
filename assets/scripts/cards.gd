extends GridContainer


func _on_card_pressed(card: Control) -> void:
	if !card.face and owner.cur_step >= 0:
		card.flip_card()
		owner.cur_step += 1
		if owner.cur_step == int(card.text):
			if owner.cur_step == owner.nums.size(): #9
				owner.emit_signal("win")
		else:
			yield(card.card_anim_player, "animation_finished")
			owner.emit_signal("fail")


func open_cards():
	for card in get_children():
		yield(get_tree().create_timer(0.09), "timeout")
		card.flip_card(true)


func close_cards():
	for card in get_children():
		yield(get_tree().create_timer(0.09), "timeout")
		card.flip_card(false, true)
