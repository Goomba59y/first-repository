extends Node

var save_filepath = "user://save_file.save"

func _ready():
	yield(get_tree().create_timer(0.1), "timeout")

func save_game():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("user://saved_scene.tscn", packed_scene)
	yield(get_tree().create_timer(0.05), "timeout")
	_save()


func _save():
	var dic = {}
	var nodes = get_tree().get_nodes_in_group("scene")
	for node in nodes:
		node.call("save_data")
	for key in Cache.get_meta_list():
		dic[key] = Cache.get_meta(key)
	
	Utils.write_json_data(save_filepath, dic)

	# DEBUGGING INFO
	print("Printing keys & Their Values...")
	for key in dic.keys():
		print(key + " --> " + str(dic[key]))


func load_game():
	get_tree().change_scene("user://saved_scene.tscn")
	yield(get_tree().create_timer(0.05), "timeout")
	_load()

func _load():
	var parsed_data = Utils.read_json_file(save_filepath)
	if parsed_data != null:
		Cache.data = parsed_data
		var nodes = get_tree().get_nodes_in_group("scene")
		for node in nodes:
			node.call("load_data")
	else:
		print("Uh oh, Failed to parse save file, sad")
