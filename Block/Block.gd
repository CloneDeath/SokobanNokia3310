extends KinematicBody2D

var on_block = 0;

func push(dp):
	var space_state = get_world_2d().direct_space_state;
	var results = space_state.intersect_point(self.global_position + dp);
	if (results.size() == 0):
		self.position += dp;
		return true;
	return false;

func _process(_delta):
	if (on_block > 0):
		$Sprite.frame = 1;
	else:
		$Sprite.frame = 0;

func enter_button():
	on_block += 1;

func exit_button():
	on_block -= 1;