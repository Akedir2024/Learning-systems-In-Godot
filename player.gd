extends CharacterBody3D
# means it inherits from the characterbody3d attributes
var speed
@export var jump_speed:float = 5.0
@export var gravity:float = 20.5
@export var run_speed:float = 10.0
@export var walk_speed:float = 6.0
#Camera build
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _unhandled_input(event:InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * 0.3
		
		%Camera3D.rotation_degrees.x -= event.relative.y * 0.3
		%Camera3D.rotation_degrees.x = clamp(
			%Camera3D.rotation_degrees.x,-80,80
		)
	
	#character movement
func _physics_process(delta: float) -> void:
	#this function runs many times persecond so unless we are pressing a movement key dir is set to zero 
	var dir = Vector3.ZERO
	if Input.is_action_pressed("shift"):
		speed = run_speed
	else:
		speed = walk_speed
		
		#we keep the w out so people can run and jump but they shouldnt be able to strafe side to side mid air
	if Input.is_action_pressed("move_forward"):
		dir  -= transform.basis.z
		
	if is_on_floor() == true:
		if Input.is_action_pressed("move_back"):
			dir += transform.basis.z
		if Input.is_action_pressed("move_left"):
			dir -= transform.basis.x
		if Input.is_action_pressed("move_right"):
			dir += transform.basis.x
		if Input.is_action_pressed("esc"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
		
		
		
	velocity.y -= gravity * delta
	if Input.is_action_just_pressed("jump")and is_on_floor():
		velocity.y = jump_speed
		
	dir = dir.normalized()
	
	velocity.z = dir.z * speed
	velocity.x = dir.x * speed
	
	#for testing 
	#print('z:',velocity.z)
	#print("x:",velocity.x)
	
	
	move_and_slide()
		
	
		
		
		
