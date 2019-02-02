extends KinematicBody2D

func push(dp):
	var space_state = get_world_2d().direct_space_state;
	var results = space_state.intersect_point(self.global_position + dp);
	if (results.size() == 0):
		self.position += dp;
		return true;
	return false;

func enter_button():
	$Sprite.frame = 1;

func exit_button():
	$Sprite.frame = 0;