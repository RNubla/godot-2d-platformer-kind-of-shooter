extends Sprite

func _physics_process(delta):
#	var point = $Sprite
#	point.set_offset
#	edit_set_pivot()
	look_at(get_global_mouse_position())