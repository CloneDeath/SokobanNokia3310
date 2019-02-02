extends KinematicBody2D

const SPEED: int = 6;

export var stopped = false;

func _ready():
	$AnimationPlayer.play("right");

func _physics_process(_delta):
	if (stopped):
		$AnimationPlayer.stop();
		return;

	var LEFT = Input.is_action_just_pressed("ui_left");
	var RIGHT = Input.is_action_just_pressed("ui_right");
	var UP = Input.is_action_just_pressed("ui_up");
	var DOWN = Input.is_action_just_pressed("ui_down");

	var currentTime = $AnimationPlayer.current_animation_position;
	if (LEFT):
		$AnimationPlayer.play("left");
	if (RIGHT):
		$AnimationPlayer.play("right");
	$AnimationPlayer.seek(currentTime);

	var dp = Vector2(0, 0);
	if (LEFT):
		dp.x = -SPEED;
	elif (RIGHT):
		dp.x = SPEED;
	elif (UP):
		dp.y = -SPEED;
	elif(DOWN):
		dp.y = SPEED;
	try_to_move(dp);

func try_to_move(dp):
	var space_state = get_world_2d().direct_space_state;
	var results = space_state.intersect_point(self.global_position + dp);
	if (results.size() == 0):
		move_player(dp);
		return;
	for item in results:
		if (item.collider.has_method("push")):
			var pushed = item.collider.push(dp);
			if (!pushed):
				return;
		else:
			return;
	move_player(dp);

func move_player(dp):
	$PlayerMove.play();
	self.position += dp;
