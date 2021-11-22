extends KinematicBody2D

const GRAVITY = 500.0
const WALK_SPEED = 100
const JUMP_FORCE = 150
const RUN_MULTIPLIER = 10
const JUMP_MULTIPLIER = 2

const LANTERN_BURN_RATE = 0.1

var lantern_fuel = 1.0

var rng = RandomNumberGenerator.new()
var velocity = Vector2()
var speed_mod = 1
var jump_mod = 1

func handle_player_movement(delta):
	velocity.y += delta * GRAVITY
	
	if Input.is_action_pressed("run"):
		jump_mod = JUMP_MULTIPLIER
		speed_mod = RUN_MULTIPLIER
	else:
		jump_mod = 1
		speed_mod = 1

	if Input.is_action_pressed("ui_left"):
		velocity.x = -(WALK_SPEED * speed_mod)
	elif Input.is_action_pressed("ui_right"):
		velocity.x =  (WALK_SPEED * speed_mod)
	else:
		velocity.x = lerp(velocity.x, 0, 0.1)

	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -JUMP_FORCE * jump_mod
	
	if velocity.x != 0:
		$AnimatedSprite.flip_h = velocity.x < 0

	move_and_slide(velocity, Vector2(0, -1))

func change_lantern_intensity(intensity):
	get_node("Lantern/LanternLight").set_energy(intensity)

func _on_FlickerTimer_timeout():
	if lantern_fuel < 0:
		reset_lantern()
	else:
		lantern_fuel -= LANTERN_BURN_RATE
		change_lantern_intensity(lantern_fuel)

func reset_lantern():
	deactivate_lantern()
	activate_lantern()

func deactivate_lantern():
	get_node("Lantern/LanternLight/FlickerTimer").stop()
	get_node("Lantern/LanternLight").hide()

func activate_lantern():
	lantern_fuel = 1.0
	get_node("Lantern/LanternLight").show()
	get_node("Lantern/LanternLight/FlickerTimer").start()

func _ready():
	rng.randomize()
	activate_lantern()

func _physics_process(delta):
	handle_player_movement(delta)
