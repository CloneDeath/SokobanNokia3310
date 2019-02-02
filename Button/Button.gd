extends Area2D

func is_pressed():
	var bodies = self.get_overlapping_bodies();
	for body in bodies:
		if (body.is_in_group("block")):
			return true;
	return false;

func _on_Button_body_entered(body):
	if (body.has_method("enter_button")):
		body.enter_button();

func _on_Button_body_exited(body):
	if (body.has_method("exit_button")):
		body.exit_button();
