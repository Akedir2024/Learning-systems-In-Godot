extends CharacterBody3D
@export var player:CharacterBody3D

@export var chase_speed: float = 7.0
@export var walk_speed: float = 5.0



@onready var agent: NavigationAgent3D = $NavigationAgent3D

#var destination: Vector3 = Vector3(12.0, 0.5, -4.0)

func _ready() -> void:
	setup_navigation.call_deferred()

func setup_navigation() -> void:
	await get_tree().physics_frame
	#agent.target_position = player.global_position
	#print("Start: ", global_position, " Target: ", agent.target_position)

func _physics_process(_delta: float) -> void:
	#print("Finished: ", agent.is_navigation_finished())
	agent.target_position = player.global_position
	if agent.is_navigation_finished():
		velocity = Vector3.ZERO
		return

	var next_point: Vector3 = agent.get_next_path_position()
	var direction: Vector3 = global_position.direction_to(next_point)

	velocity = direction * chase_speed
	

	move_and_slide()
	
signal hit
	
func die():
	hit.emit()
	queue_free()


func _on_mob_detector_body_entered(CharacterBody3D):
	die()
		
	
	
	
	
