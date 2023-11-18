extends Node

signal zoom_changed(zoom_value)

var zoom:float = 2:
	set(new_zoom):
		zoom=new_zoom
		zoom_changed.emit(new_zoom)
	get:
		return zoom



