extends KinematicBody2D

const SPEED: int = 6;

func _ready():
	$AnimationPlayer.play("right");

func _physics_process(_delta):
	var LEFT = Input.is_action_just_pressed("ui_left");
	var RIGHT = Input.is_action_just_pressed("ui_right");
	var UP = Input.is_action_just_pressed("ui_up");
	var DOWN = Input.is_action_just_pressed("ui_down");

	var currentTime = $AnimationPlayer.current_animation_position;
	if (LEFT): $AnimationPlayer.play("left");
	if (RIGHT): $AnimationPlayer.play("right");
	$AnimationPlayer.seek(currentTime);

	var dp = Vector2((int(RIGHT) - int(LEFT)) * SPEED, (int(DOWN) - int(UP)) * SPEED);
	var space_state = get_world_2d().direct_space_state;
	var results = space_state.intersect_point(self.global_position + dp);
	if (results.size() == 0):
		self.position += dp;