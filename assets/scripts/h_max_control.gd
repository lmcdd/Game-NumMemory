extends Control

func _ready():
	get_parent().connect("resized", self, "_on_resize")


func _on_resize():
	rect_min_size.y = get_parent().rect_size.y

