extends Node2D  

var easy_modules: Array = []
var medium_modules: Array = []
var hard_modules: Array = []

func _ready():
	easy_modules = load_module_scenes("res://modules/Easy_Rooms/")
	medium_modules = load_module_scenes("res://modules/Medium_Rooms/")
	hard_modules = load_module_scenes("res://modules/Hard_Rooms/")
	print("Easy modules loaded: ", easy_modules.size(), medium_modules.size(), hard_modules.size())
	print("[ModuleManager] Ready. Generating world...")
	generate_world()

func load_module_scenes(path: String) -> Array:
	var modules: Array = []
	var dir = DirAccess.open(path)

	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".tscn") and not dir.current_is_dir():
				var scene_path = path + file_name
				var packed_scene = load(scene_path)
				if packed_scene:
					modules.append(packed_scene)
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		push_error("Failed to open directory: " + path)

	return modules

const TILE_SIZE: int = 16  # Standard tile size

@export var num_easy: int = 2
@export var num_medium: int = 2
@export var num_hard: int = 6
@export var start_position: Vector2 = Vector2(-8, -152)  # Where the first module starts
@export var module_height: int = 160  # Vertical spacing between modules

func generate_world():
	var current_position = start_position

	# Generate easy rooms
	for i in range(num_easy):
		print("[ModuleManager] Placing an Easy Room...")
		place_random_room(easy_modules, current_position)
		current_position.y -= module_height

	# Generate medium rooms
	for i in range(num_medium):
		print("[ModuleManager] Placing a Medium Room...")
		place_random_room(medium_modules, current_position)
		current_position.y -= module_height

	# Generate hard rooms
	for i in range(num_hard):
		print("[ModuleManager] Placing a Hard Room...")
		place_random_room(hard_modules, current_position)
		current_position.y -= module_height

func place_random_room(room_array: Array, position: Vector2):
	if room_array.size() > 0:
		var packed_scene = room_array[randi() % room_array.size()]  
		print("[ModuleManager] Loading scene:", packed_scene.resource_path)

		var room_instance = packed_scene.instantiate()
		room_instance.position = position  
		add_child(room_instance)  
		print("[ModuleManager] Placed room at:", position)
